import 'package:untitled/core/constants/imports.dart';

abstract class RegistrationState extends BaseState {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  final bool passwordVisible;
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasValidLength;

  const RegistrationInitial({
    this.passwordVisible = false,
    this.hasCapitalLetter = false,
    this.hasNumber = false,
    this.hasValidLength = false,
  });

  bool get isPasswordVisible => passwordVisible;

  bool get isPasswordValid => hasCapitalLetter && hasNumber && hasValidLength;
}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure(this.error);
}