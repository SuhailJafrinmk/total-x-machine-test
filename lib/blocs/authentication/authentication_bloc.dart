import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    emit(LoginScreenLoadingState());
    try{
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
      codeAutoRetrievalTimeout: (String verificationId){});
    }catch(e){
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }

  FutureOr<void> onPhoneOtpSend(OnPhoneOtpSend event, Emitter<AuthenticationState> emit) {
    emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
  }

  FutureOr<void> verfiySendOtp(VerfiySendOtp event, Emitter<AuthenticationState> emit) {
    try{
      PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otpCode);
      add(OnPhoneAuthVerificationCompletedEvent(credential: credential));
    }catch(e){
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }

  FutureOr<void> onPhoneAuthenticationError(OnPhoneAuthenticationError event, Emitter<AuthenticationState> emit){
   emit(LoginScreenErrorState(error: event.error));
  }

  FutureOr<void> onPhoneAuthVerificationCompletedEvent(OnPhoneAuthVerificationCompletedEvent event, Emitter<AuthenticationState> emit)async {
    try {
      await firebaseService.auth.signInWithCredential(event.credential);
      emit(LoginScreenOtpSuccessState());
    } catch (e) {
      emit(LoginScreenErrorState(error: e.toString()));
    }
  }
}
