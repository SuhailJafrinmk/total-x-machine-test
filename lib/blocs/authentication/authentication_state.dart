part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}
class LoginScreenLoadingState extends AuthenticationState{

}
class LoginScreenInitialState extends AuthenticationState{}
class LoginScreenLoadedState extends AuthenticationState{}
class LoginScreenErrorState extends AuthenticationState{
  final String error;
  LoginScreenErrorState({required this.error});
}
class PhoneAuthCodeSentSuccess extends AuthenticationState{
  final String verificationId;
  PhoneAuthCodeSentSuccess({required this.verificationId});
}
class LoginScreenOtpSuccessState extends AuthenticationState{}


