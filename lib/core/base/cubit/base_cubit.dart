import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  void togglePasswordVisibility();

  bool validateForm(GlobalKey<FormState> formKey) => formKey.currentState!.validate();
}