import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
enum AuthState { idle, loading, verified, error ,otpSended}

class AuthenticationProvider with ChangeNotifier {
  final FirebaseService firebaseService;
  AuthState _state = AuthState.idle;
  String _errorMessage = '';
  AuthState get state => _state;
  String get errorMessage => _errorMessage;
  String _firebaseVerificationId = '';
  String get firebaseVerificationId => _firebaseVerificationId;

  AuthenticationProvider({required this.firebaseService});

  void _updateState(AuthState newState, {String? error}) {
    _state = newState;
    if (error != null) {
      _errorMessage = error;
    }
    notifyListeners();
  }

  Future<void> sendOtpToPhone(String phoneNumber) async {
    if (!(await _checkNetworkConnectivity())) {
      _updateState(AuthState.error, error: 'No internet connection');
      return;
    }
    _updateState(AuthState.loading); 

    try {
      await _retryOtpSend(phoneNumber);
    } catch (e) {
      _handleException(e);
    }
  }


  Future<void> _retryOtpSend(String phoneNumber, {int retryCount = 3}) async {
    int attempts = 0;
    while (attempts < retryCount) {
      try {
        await firebaseService.loginWithPhone(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
            await onPhoneAuthVerificationCompleted(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) async {
            await onPhoneAuthenticationError(firebaseAuthException);
          },
          codeSent: (String verificationId, int? refreshToken) {
            logInfo('OTP sent to $phoneNumber');
            _firebaseVerificationId=verificationId;
            logInfo('the verification id is $_firebaseVerificationId');
            _updateState(AuthState.otpSended); 
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            logWarning('OTP auto-retrieval timed out');
          },
        );
        return; 
      } catch (e) {
        attempts++;
        if (attempts >= retryCount) {
          throw e; 
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }


  Future<void> onPhoneAuthVerificationCompleted(AuthCredential authCredential) async {
    try {
      UserCredential userCredential=await firebaseService.auth.signInWithCredential(authCredential);
       if (userCredential.user != null) {
      logInfo('User authenticated successfully with UID: ${userCredential.user!.uid}');
      await _createUserInFirestore(userCredential.user!);
      _updateState(AuthState.verified);
    }
    } catch (e) {
      _handleException(e);
    }
  }

  Future<void> onPhoneAuthenticationError(FirebaseAuthException firebaseAuthException) async {
    _handleException(firebaseAuthException);
  }
  Future<void> verifyRecievedOtp(String verficationId,String smsCode)async{
    try {
      PhoneAuthCredential phoneAuthCredential=PhoneAuthProvider.credential(verificationId: verficationId, smsCode: smsCode);
      await onPhoneAuthVerificationCompleted(phoneAuthCredential);
      _updateState(AuthState.verified);
    } catch (e) {
      _handleException(e);
    }
  }

  void _handleException(Object e) {
    if (e is FirebaseAuthException) {
      logError('FirebaseAuthException: ${e.message}');
      _updateState(AuthState.error, error: e.message);
    } else {
      logError('An unexpected error occurred: ${e.toString()}');
      _updateState(AuthState.error, error: 'An unexpected error occurred. Please try again.');
    }
  }

  Future<bool> _checkNetworkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      logWarning('No internet connection');
      return false;
    }
    return true;
  }

  Future<void> _createUserInFirestore(User user) async {
  try {
    final userData = {
      'uid': user.uid,
      'phoneNumber': user.phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await firebaseService.firestore.collection('Users').doc(user.uid).set(userData);
    logInfo('User data successfully stored in Firestore for UID: ${user.uid}');
  } catch (e) {
    logError('Failed to store user data in Firestore: ${e.toString()}');
    throw Exception('Failed to store user data in Firestore');
  }
}

void resetStates(){
  _state=AuthState.idle;
}


}





// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
// import 'dart:developer' as developer;

// import 'package:totelx_machine_test/services/firebase_service.dart';
// part 'authentication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
//   String loginResult='';
//   FirebaseService firebaseService=FirebaseService();
//   UserCredential ? userCredential;
//   AuthenticationBloc(super.initialState) {
//   on<SendOtpToPhone>(sendOtpToPhone);
//   on<OnPhoneOtpSend>(onPhoneOtpSend);
//   on<VerfiySendOtp>(verfiySendOtp);
//   on<OnPhoneAuthenticationError>(onPhoneAuthenticationError);
//   on<OnPhoneAuthVerificationCompletedEvent>(onPhoneAuthVerificationCompletedEvent);
//   }



//   FutureOr<void> sendOtpToPhone(SendOtpToPhone event, Emitter<AuthenticationState> emit)async{
//     developer.log('requesing to send otp from firebase');
//     emit(LoginScreenLoadingState());
//     try{
//       developer.log('the phone number is printing from sendotptophone fn ${event.phoneNumber}');
//      await firebaseService.loginWithPhone(
//       phoneNumber: event.phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credentials){
//         add(OnPhoneAuthVerificationCompletedEvent(credential: credentials));
//       },
//       verificationFailed: (FirebaseAuthException e){
//         add(OnPhoneAuthenticationError(error: e.toString()));
//       },
//       codeSent: (String verificationId,int ? refreshToken){
//         add(OnPhoneOtpSend(verificationId: verificationId, token: refreshToken));
//       },
//       codeAutoRetrievalTimeout: (String verificationId){
//         developer.log('error....time out........');
//       });
//     }catch(e){
//       developer.log('an error occured and error is ${e.toString()}');
//       emit(LoginScreenErrorState(error: e.toString()));
//     }
//   }

//   FutureOr<void> onPhoneOtpSend(OnPhoneOtpSend event, Emitter<AuthenticationState> emit) {
//     emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
//     developer.log('otp code has sented successfully to the provided number');
//   }

//   FutureOr<void> verfiySendOtp(VerfiySendOtp event, Emitter<AuthenticationState> emit) {
//     developer.log('the function is now verifying the otp....');
//     try{
//       PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otpCode);
//       developer.log('a new credential is created with the provided phone number');
//       add(OnPhoneAuthVerificationCompletedEvent(credential: credential));
//     }catch(e){
//       developer.log('an error occured while veriying the otp');
//       emit(LoginScreenErrorState(error: e.toString()));
//     }
//   }

//   FutureOr<void> onPhoneAuthenticationError(OnPhoneAuthenticationError event, Emitter<AuthenticationState> emit){
//     developer.log('an error occured while authenticating user${event.error}');
//    emit(LoginScreenErrorState(error: event.error));
//   }

//   FutureOr<void> onPhoneAuthVerificationCompletedEvent(OnPhoneAuthVerificationCompletedEvent event, Emitter<AuthenticationState> emit)async {
//     try {
//       await firebaseService.auth.signInWithCredential(event.credential);
//       developer.log('a new user is logged in and credential is created with provided phone number');
//       emit(LoginScreenOtpSuccessState());
//     } catch (e) {
//       developer.log('there is an error while authenticating');
//       emit(LoginScreenErrorState(error: e.toString()));
//     }
//   }
// }
