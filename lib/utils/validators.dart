import 'package:get/get.dart';

class Validators {
  static const usernameError = "Please enter valid email or phone number";
  static const passwordError = "Password should be minimum 4 characters";
  static const passwordMatchError = "Password mismatch";
  static const emailError = "Please enter valid email Id";
  static const emailPhoneNumberError = "Please enter valid email Id or phone number";
  static const phoneError = "Please enter valid phone number";
  static const nameError = "Please enter valid name";
  static const passCodeError = "Field cannot be empty";

  static checkValidation(String controller, bool validator){
    if(controller.isEmpty){ validator = true;}
    else{
      validator = false;
    }
  }
  static String isValidUserName(String username) {
    String msg;
    if (username.isNotEmpty &&
        (isEmailValid(username) || isValidNumber(username))) {
      msg = "";
    } else {
      msg = usernameError;
    }
    return msg;
  }

  static String isValidEmailId(String emailId) {
    String msg;
    if (emailId.isNotEmpty && isEmailValid(emailId)) {
      msg = "";
    } else {
      msg = emailError;
    }
    return msg;
  }

  static String isValidEmailIdORPhoneNumber(String emailId) {
    String msg;
    if (emailId.isNotEmpty &&
        (isEmailValid(emailId) || isValidNumber(emailId))) {
      msg = "";
    } else {
      msg = emailPhoneNumberError;
    }
    return msg;
  }

  static String isValidOtp(String otp) {
    String msg;
    if (otp.isNotEmpty && otp.length == 4) {
      msg = "";
    } else {
      msg = "Enter valid otp";
    }
    return msg;
  }

  static String isValidPhoneNo(String number) {
    String msg;
    if (number.isNotEmpty && isValidNumber(number)) {
      msg = "";
    } else {
      msg = phoneError;
    }
    return msg;
  }

  static String isValidName(String name) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);

    String msg;
    if (name.isNotEmpty && regExp.hasMatch(name)) {
      msg = "";
    } else {
      msg = nameError;
    }
    return msg;
  }

  static bool isEmailValid(String value) {
    if (!GetUtils.isEmail(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static String isValidPassword(String password) {
    String msg;
    if (password.isNotEmpty && password.length >= 4) {
      msg = "";
    } else {
      msg = passwordError;
    }

    return msg;
  }

  static String isSamePasswords(String password1, String password2) {
    String msg;
    if (password1 == password2) {
      msg = "";
    } else {
      msg = passwordMatchError;
    }

    return msg;
  }

  static String isValidPasswords(String password1, String password2) {
    String msg;
    if (password2.isNotEmpty && password2.length >= 4) {
      if (password1 == password2) {
        msg = "";
      } else {
        msg = passwordMatchError;
      }
    } else {
      msg = passwordError;
    }

    return msg;
  }

  static String isEmpty(String value) {
    String msg;

    if (value.isNotEmpty) {
      msg = "";
    } else {
      msg = passCodeError;
    }

    return msg;
  }
}
