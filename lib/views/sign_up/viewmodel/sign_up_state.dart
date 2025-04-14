part of sign_up;

abstract class SignUpState extends BaseState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  final bool passwordVisible;
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasValidLength;

  const SignUpInitial({
    this.passwordVisible = false,
    this.hasCapitalLetter = false,
    this.hasNumber = false,
    this.hasValidLength = false,
  });

  bool get isPasswordVisible => passwordVisible;

  bool get isPasswordValid => hasCapitalLetter && hasNumber && hasValidLength;
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure(this.error);
}