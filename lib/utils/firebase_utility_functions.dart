import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils{
   static String handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-phone-number':
        return 'The phone number is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}