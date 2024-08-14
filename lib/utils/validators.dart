class ValidatorFunctions{
String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter name';
  } 
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegExp.hasMatch(value)) {
    return 'Name should contain only letters and spaces';
  }
  return null;
}

  String? phoneNumberValidate(value) {
    final RegExp pattern = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
    if (!pattern.hasMatch(value)) {
      return 'Invalid mobile number';
    }

    return null;
  }
}