
class PhoneVerificationFailure {
  final String message;
  PhoneVerificationFailure(this.message);
}

class InvalidPhoneNumber extends PhoneVerificationFailure {
  InvalidPhoneNumber() : super('The provided phone number is not valid.');
}

class TooManyRequests extends PhoneVerificationFailure {
  TooManyRequests() : super('Too many requests. Please try again later.');
}

class GeneralPhoneVerificationFailure extends PhoneVerificationFailure {
  GeneralPhoneVerificationFailure(String message) : super(message);
}