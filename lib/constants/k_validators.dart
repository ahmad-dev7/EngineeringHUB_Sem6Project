//* college validator
import 'package:get/get_utils/src/get_utils/get_utils.dart';

String? collegeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select college';
  }
  return null;
}

//* branch validator
String? branchValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select branch';
  }
  return null;
}

//* semester validator
String? semesterValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select semester';
  }
  return null;
}

//* name validator
String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

//* email validator
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!GetUtils.isEmail(value)) {
    return 'Please enter valid email';
  }
  return null;
}

//* password validator
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 6) {
    return 'Password length should be atleast 6';
  }
  return null;
}

//* phone number validator
String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  } else if (!GetUtils.isPhoneNumber(value)) {
    return 'Please enter valid phone number';
  }
  return null;
}
