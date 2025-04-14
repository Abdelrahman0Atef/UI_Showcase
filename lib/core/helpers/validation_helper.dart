import 'package:untitled/core/resources/my_strings.dart';

class ValidationHelper {
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return MyStrings.enterPhoneNumber;
    if (phone.length != 11) return MyStrings.phonerNumbersCheck;
    if (!phone.startsWith('01')) return MyStrings.phoneNumberStart;
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(phone)) return MyStrings.phoneNumberHaveOnlyNumbers;
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return MyStrings.enterEmail;
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) return MyStrings.emailCheck;
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return MyStrings.passwordEmpty;
    if (password.length < 8) return MyStrings.passwordLength;
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return MyStrings.nameEmpty;
    }
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
    if (!nameRegex.hasMatch(name)) {
      return MyStrings.nameHaveOnlyLetters;
    }
    return null;
  }

  static bool hasCapitalLetter(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  static bool hasValidLength(String password) {
    return password.length >= 8;
  }
}