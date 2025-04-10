import 'package:untitled/core/constants/imports.dart';

abstract class RegistrationState extends BaseState {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  final bool passwordVisible;

  const RegistrationInitial({this.passwordVisible = false});

  bool get isPasswordVisible => passwordVisible;
}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure(this.error);
}