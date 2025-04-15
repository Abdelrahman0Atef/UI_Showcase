// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) => Future.value(mapLocales[locale.toString()]);

  static const Map<String,dynamic> _ar = {
  "Auth": {
    "signInWithPhoneNumber": "الدخول برقم الهاتف",
    "signIn": "تسجيل الدخول",
    "enterPhoneNumber": "ادخل رقم الهاتف",
    "sendConfirmationCode": "ارسال رمز التأكيد",
    "createAnAccount": "انشاء حساب",
    "signInAsVisitor": "الدخول كزائر",
    "userName": "اسم المستخدم",
    "Password": "الرقم السري",
    "forgotYourPassword": "هل نسيت كلمة السر؟",
    "pleaseEnterPhoneNumber": "يرجى إدخال رقم الهاتف",
    "phoneNumberMustContain11Digits": "رقم الهاتف يجب أن يحتوي على 11 رقمًا",
    "phoneNumberMustStartWith01": "رقم الهاتف يجب أن يبدأ بـ 01",
    "phoneNumberMustContainNumbersOnly": "رقم الهاتف يجب أن يحتوي على أرقام فقط",
    "pleaseEnterYourEmail": "يرجى إدخال البريد الإلكتروني",
    "pleaseEnterValidEmailAddress": "يرجى إدخال بريد إلكتروني صحيح",
    "signInAsGuest": "الدخول كزائر",
    "firstName": "الاسم الاول",
    "LastName": "الاسم الاخير",
    "email": "البريد الالكتروني",
    "phoneNumber": "رقم الهاتف",
    "atLeastItContainsCapitalLetter": "علي الاقل يحتوي علي حرف كبير",
    "atLeastItContainsOneNumber": "علي الاقل يحتوي علي رقم واحد",
    "atLeast8Letters": "علي الاقل مكون من 8 حروف",
    "passwordCannotBeEmpty": "كلمة السر لا يمكن أن تكون فارغه",
    "nameCannotBeEmpty": "الاسم لا يمكن أن يكون فارغا",
    "nameMustContainOnlyLetters": "الاسم يجب أن يحتوي على حروف فقط",
    "thereIsAnErrorInTheData": "فيه خطأ في البيانات من فضلك راجع الحقول",
    "rememberMe": "تذكرني",
    "youHaveBeenLoggedInSuccessfully": "تم تسجيل الدخول بنجاح"
  }
};
static const Map<String,dynamic> _en = {
  "Auth": {
    "signInWithPhoneNumber": "Sign in with phone number",
    "signIn": "Sign In",
    "enterPhoneNumber": "Enter phone number",
    "sendConfirmationCode": "Send confirmation code",
    "createAnAccount": "Create an account",
    "signInAsVisitor": "Sign in as a visitor",
    "userName": "Username",
    "Password": "Password",
    "forgotYourPassword": "Forgot your password?",
    "pleaseEnterPhoneNumber": "Please enter phone number",
    "phoneNumberMustContain11Digits": "Phone number must contain 11 digits",
    "phoneNumberMustStartWith01": "Phone number must start with 01",
    "phoneNumberMustContainNumbersOnly": "Phone number must contain numbers only",
    "pleaseEnterYourEmail": "Please enter your email",
    "pleaseEnterValidEmailAddress": "Please enter a valid email address",
    "signInAsGuest": "Guest",
    "firstName": "First name",
    "LastName": "Last name",
    "email": "Email",
    "phoneNumber": "Phone number",
    "atLeastItContainsCapitalLetter": "Must contain at least one capital letter",
    "atLeastItContainsOneNumber": "Must contain at least one number",
    "atLeast8Letters": "Must be at least 8 characters long",
    "passwordCannotBeEmpty": "Password cannot be empty",
    "nameCannotBeEmpty": "Name cannot be empty",
    "nameMustContainOnlyLetters": "Name must contain letters only",
    "thereIsAnErrorInTheData": "There is an error in the data, please check the fields",
    "rememberMe": "Remember me",
    "youHaveBeenLoggedInSuccessfully": "You have been logged in successfully"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
