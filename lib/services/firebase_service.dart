import 'dart:async';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/utils/typedef.dart';
import 'package:path/path.dart' as path;

class FirebaseService {
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
   User ? firebaseUser;
   final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> loginWithPhone(
    {
      required String phoneNumber,
      required Function(PhoneAuthCredential)verificationCompleted,
      required Function(FirebaseAuthException)verificationFailed,
      required Function(String,int ?)codeSent,
      required Function(String)codeAutoRetrievalTimeout,
    }
  )async{
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
  
   Result addUser(UserModel userModel)async{
    try {
      await firestore.collection('Users').doc(userModel.username).set(userModel.toMap());
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
   }
Future<Either<String, String>> uploadImage(XFile image) async {
  try {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = path.basename(image.path);
    final Reference ref = storage.ref().child('images/$fileName');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return Right(downloadUrl);
  } catch (e) {
    return Left(e.toString());
  }
}
   

}
