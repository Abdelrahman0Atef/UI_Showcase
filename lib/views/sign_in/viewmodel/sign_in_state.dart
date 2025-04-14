part of sign_in;

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
}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure(this.error);
}