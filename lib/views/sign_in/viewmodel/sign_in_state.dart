part of '../sign_in_imports.dart';

abstract class SignInState extends BaseState {
  const SignInState();
}

class SignInInitial extends SignInState {
  final int selectedIndex;
  final bool passwordVisible;
  final bool isEmailRememberMeChecked;
  final bool isPhoneRememberMeChecked;
  final String savedEmail;
  final String savedPassword;
  final String savedPhone;

  const SignInInitial(
      this.selectedIndex,
      this.passwordVisible, {
        this.isEmailRememberMeChecked = false,
        this.isPhoneRememberMeChecked = false,
        this.savedEmail = '',
        this.savedPassword = '',
        this.savedPhone = '',
      });

  bool get isPasswordVisible => passwordVisible;

  SignInInitial copyWith({
    int? selectedIndex,
    bool? passwordVisible,
    bool? isEmailRememberMeChecked,
    bool? isPhoneRememberMeChecked,
    String? savedEmail,
    String? savedPassword,
    String? savedPhone,
  }) => SignInInitial(
      selectedIndex ?? this.selectedIndex,
      passwordVisible ?? this.passwordVisible,
      isEmailRememberMeChecked: isEmailRememberMeChecked ?? this.isEmailRememberMeChecked,
      isPhoneRememberMeChecked: isPhoneRememberMeChecked ?? this.isPhoneRememberMeChecked,
      savedEmail: savedEmail ?? this.savedEmail,
      savedPassword: savedPassword ?? this.savedPassword,
      savedPhone: savedPhone ?? this.savedPhone,
    );
}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure(this.error);
}
