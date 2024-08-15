import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

import 'package:totelx_machine_test/services/firebase_service.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  String loginResult='';
  FirebaseService firebaseService=FirebaseService();
  UserCredential ? userCredential;
  AuthenticationBloc(super.initialState) {
  on<SendOtpToPhone>(sendOtpToPhone);
  on<OnPhoneOtpSend>(onPhoneOtpSend);
  on<VerfiySendOtp>(verfiySendOtp);
  on<OnPhoneAuthenticationError>(onPhoneAuthenticationError);
  on<OnPhoneAuthVerificationCompletedEvent>(onPhoneAuthVerificationCompletedEvent);
  }



  FutureOr<void> sendOtpToPhone(SendOtpToPhone event, Emitter<AuthenticationState> emit)async{
    developer.log('requesing to send otp from firebase');
    emit(LoginScreenLoadingState());
    try{
      developer.log('the phone number is printing from sendotptophone fn ${event.phoneNumber}');
     await firebaseService.loginWithPhone(
      phoneNumber: event.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credentials){
        add(OnPhoneAuthVerificationCompletedEvent(credential: credentials));
      },
      verificationFailed: (FirebaseAuthException e){
        add(OnPhoneAuthenticationError(error: e.toString()));
      },
      codeSent: (String verificationId,int ? refreshToken){
        add(OnPhoneOtpSend(verificationId: verificationId, token: refreshToken));
      },
      codeAutoRetrievalTimeout: (String verificationId){
        developer.log('error....time out........');
      });
    }catch(e){
      developer.log('an error occured and error is ${e.toString()}');
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }

  FutureOr<void> onPhoneOtpSend(OnPhoneOtpSend event, Emitter<AuthenticationState> emit) {
    emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
    developer.log('otp code has sented successfully to the provided number');
  }

  FutureOr<void> verfiySendOtp(VerfiySendOtp event, Emitter<AuthenticationState> emit) {
    developer.log('the function is now verifying the otp....');
    try{
      PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otpCode);
      developer.log('a new credential is created with the provided phone number');
      add(OnPhoneAuthVerificationCompletedEvent(credential: credential));
    }catch(e){
      developer.log('an error occured while veriying the otp');
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }

  FutureOr<void> onPhoneAuthenticationError(OnPhoneAuthenticationError event, Emitter<AuthenticationState> emit){
    developer.log('an error occured while authenticating user');
   emit(LoginScreenErrorState(error: event.error));
  }

  FutureOr<void> onPhoneAuthVerificationCompletedEvent(OnPhoneAuthVerificationCompletedEvent event, Emitter<AuthenticationState> emit)async {
    try {
      await firebaseService.auth.signInWithCredential(event.credential);
      developer.log('a new user is logged in and credential is created with provided phone number');
      emit(LoginScreenOtpSuccessState());
    } catch (e) {
      developer.log('there is an error while authenticating');
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }
}
