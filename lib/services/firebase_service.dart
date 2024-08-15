import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totelx_machine_test/utils/exceptions.dart';

class FirebaseService {
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User ? firebaseUser;

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
}
