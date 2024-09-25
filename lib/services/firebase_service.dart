// import 'dart:async';
// import 'dart:io';
// import 'package:either_dart/either.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:totelx_machine_test/development_only/custom_debugger.dart';
// import 'package:totelx_machine_test/model/user_model.dart';
// import 'package:totelx_machine_test/utils/typedef.dart';
// import 'package:path/path.dart' as path;

// class FirebaseService {
//    final FirebaseAuth auth = FirebaseAuth.instance;
//    final FirebaseFirestore firestore = FirebaseFirestore.instance;
//    User ? firebaseUser;
//    final FirebaseStorage storage = FirebaseStorage.instance;

//   Future<void> loginWithPhone(
//     {
//       required String phoneNumber,
//       required Function(PhoneAuthCredential)verificationCompleted,
//       required Function(FirebaseAuthException)verificationFailed,
//       required Function(String,int ?)codeSent,
//       required Function(String)codeAutoRetrievalTimeout,
//     }
//   )async{
//     await auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   }
//    //the type return is a custom type defined in utils/typedef
//    Result addUser(UserModel userModel)async{
//     try {
//       await firestore.collection('Users').doc(userModel.username).set(userModel.toMap());
//       return const Right(null);
//     } catch (e) {
//       logError('there is an error ${e.toString()}');
//       return Left(e.toString());
//     }
//    }

// Future<Either<String, String>> uploadImage(XFile image) async {
//   try {
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     final String fileName = path.basename(image.path);
//     final Reference ref = storage.ref().child('images/$fileName');
//     final UploadTask uploadTask = ref.putFile(File(image.path));
//     final TaskSnapshot snapshot = await uploadTask;
//     final String downloadUrl = await snapshot.ref.getDownloadURL();
//     logInfo('the download url of the image is $downloadUrl-printing inside upload image...');
//     return Right(downloadUrl);
//   } catch (e) {
//     logError('there is an error ${e.toString()}');
//     return Left(e.toString());
//   }
// }

//   Future<Either<String, List<UserModel>>> getUsers() async {
//     try {
//       logInfo('fetching userdata from firebase....');
//       final QuerySnapshot snapshot = await firestore.collection('Users').get();
//       final List<UserModel> users = snapshot.docs.map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       return UserModel.fromMap(data);
//       }).toList();
//       logInfo('successfully mapped the usermodels in to list');
//       return Right(users);
//     } catch (e) {
//       logError('There was an error: ${e.toString()}');
//       return Left(e.toString());
//     }
//   }

//     Result logoutUser()async{
//     try {
//       await auth.signOut();
//       return const Right(null);
//     } catch (e) {
//       logError('there is an error ${e.toString()}');
//       return Left(e.toString());
//     }
//    }
   

// }
import 'dart:async';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/utils/typedef.dart';
import 'package:path/path.dart' as path;

class FirebaseService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseService({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  Future<void> loginWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Result addUser(UserModel userModel) async {
    try {
      User ? user=auth.currentUser;
      if(user!=null){
        await firestore.collection('Users').doc(auth.currentUser?.uid).collection('Userdata').doc().set(userModel.toMap());
      }
      return const Right(null);
    } catch (e) {
      logError('there is an error ${e.toString()}');
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> uploadImage(XFile image) async {
    try {
      final String fileName = path.basename(image.path);
      final Reference ref = storage.ref(auth.currentUser?.uid).child('images/$fileName');
      final UploadTask uploadTask = ref.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      logInfo('the download url of the image is $downloadUrl - printing inside upload image...');
      return Right(downloadUrl);
    } catch (e) {
      logError('there is an error ${e.toString()}');
      return Left(e.toString());
    }
  }

  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      logInfo('fetching userdata from firebase....');
      final QuerySnapshot snapshot = await firestore.collection('Users').doc(auth.currentUser?.uid).collection('Userdata').get();
      final List<UserModel> users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data);
      }).toList();
      logInfo('successfully mapped the usermodels into list');
      return Right(users);
    } catch (e) {
      logError('There was an error: ${e.toString()}');
      return Left(e.toString());
    }
  }

  Result logoutUser() async {
    try {
      await auth.signOut();
      return const Right(null);
    } catch (e) {
      logError('there is an error ${e.toString()}');
      return Left(e.toString());
    }
  }

}

