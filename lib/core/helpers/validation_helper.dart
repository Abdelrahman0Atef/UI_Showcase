import 'package:untitled/core/constants/imports.dart';

class ValidationHelper {
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return kEnterPhoneNumber;
    if (phone.length != 11) return kPhonerNumbersCheck;
    if (!phone.startsWith('01')) return kPhoneNumberStart;
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(phone)) return kPhoneNumberHaveOnlyNumbers;
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return kEnterEmail;
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) return kEmailCheck;
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return kPasswordNotEmpty;
    if (password.length < 8) return kPasswordLength;
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return kNameNotEmpty;
    }
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
    if (!nameRegex.hasMatch(name)) {
      return kNameHaveOnlyLetters;
    }
    return null;
  }
}