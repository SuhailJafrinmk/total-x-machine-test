
// part of 'authentication_bloc.dart';



// @immutable
// sealed class AuthenticationEvent {}
// class SendOtpToPhone extends AuthenticationEvent{
//   final String phoneNumber;

//   SendOtpToPhone({required this.phoneNumber});

// }
// class OnPhoneOtpSend extends AuthenticationEvent{
//   final String verificationId;
//   final int ? token;
//   OnPhoneOtpSend({required this.verificationId, required this.token});
// }
// class VerfiySendOtp extends AuthenticationEvent{
//   final String otpCode;
//   final String verificationId;
//   VerfiySendOtp({required this.otpCode, required this.verificationId});
// }
// class OnPhoneAuthenticationError extends AuthenticationEvent{
//   final String error;

//   OnPhoneAuthenticationError({required this.error});

// }
// class OnPhoneAuthVerificationCompletedEvent extends AuthenticationEvent{
//   final AuthCredential credential;

//   OnPhoneAuthVerificationCompletedEvent({required this.credential});

// }
