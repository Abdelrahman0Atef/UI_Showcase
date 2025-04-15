import 'package:easy_localization/easy_localization.dart';
import 'package:untitled/generated/locale_keys.g.dart';

class ValidationHelper {
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return LocaleKeys.Auth_enterPhoneNumber.tr();
    if (!phone.startsWith('01')) return LocaleKeys.Auth_phoneNumberMustStartWith01.tr();
    if (phone.length != 11) return LocaleKeys.Auth_phoneNumberMustContain11Digits.tr();
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(phone)) return LocaleKeys.Auth_phoneNumberMustContainNumbersOnly.tr();
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return LocaleKeys.Auth_pleaseEnterYourEmail.tr();
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) return LocaleKeys.Auth_pleaseEnterValidEmailAddress.tr();
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return LocaleKeys.Auth_passwordCannotBeEmpty.tr();
    if (password.length < 8) return LocaleKeys.Auth_atLeast8Letters.tr();
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return LocaleKeys.Auth_nameCannotBeEmpty.tr();
    }
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
    if (!nameRegex.hasMatch(name)) {
      return LocaleKeys.Auth_nameMustContainOnlyLetters.tr();
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