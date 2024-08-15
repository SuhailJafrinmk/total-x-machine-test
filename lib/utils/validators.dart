class ValidatorFunctions{
static String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter name';
  } 
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegExp.hasMatch(value)) {
    return 'Name should contain only letters and spaces';
  }
  return null;
}

  static String? phoneNumberValidate(String ? value) {
    final RegExp pattern = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
    if(value==null ||value.isEmpty){
      return 'phone number is empty';
    }
    else if (!pattern.hasMatch(value)) {
      return 'Invalid mobile number';
    }
    return null;
  }

  
  static String? ageValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter age';
  }
  final RegExp ageRegExp = RegExp(r'^\d+$');
  if (!ageRegExp.hasMatch(value)) {
    return 'Age must be a number';
  }
  final int age = int.parse(value);
  if (age <= 0 || age > 120) {
    return 'Enter a valid age between 1 and 120';
  }
  return null;
}

}