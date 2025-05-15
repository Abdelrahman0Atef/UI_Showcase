import 'package:untitled/core/resources/my_strings.dart';

class ValidationHelper {
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return MyStrings.enterPhoneNumber;
    if (!phone.startsWith('01')) return MyStrings.phoneNumberMustStartWith01;
    if (phone.length != 11) return MyStrings.phoneNumberMustContain11Digits;
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(phone))
      return MyStrings.phoneNumberMustContainNumbersOnly;
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return MyStrings.pleaseEnterYourEmail;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email))
      return MyStrings.pleaseEnterValidEmailAddress;
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty)
      return MyStrings.passwordCannotBeEmpty;
    if (password.length < 8) return MyStrings.atLeast8Letters;
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return MyStrings.nameCannotBeEmpty;
    }
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
    if (!nameRegex.hasMatch(name)) {
      return MyStrings.nameMustContainOnlyLetters;
    }
    return null;
  }

  static bool hasCapitalLetter(String password) =>
      RegExp(r'[A-Z]').hasMatch(password);

  static bool hasNumber(String password) => RegExp(r'[0-9]').hasMatch(password);

  static bool hasValidLength(String password) => password.length >= 8;
}
