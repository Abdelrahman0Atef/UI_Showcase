import 'package:untitled/core/constants/imports.dart';

class RegistrationCubit extends BaseCubit<RegistrationState> {
  RegistrationCubit() : super(const RegistrationInitial());

  @override
  void togglePasswordVisibility() {
    if (state is RegistrationInitial) {
      final currentState = state as RegistrationInitial;
      emit(RegistrationInitial(passwordVisible: !currentState.isPasswordVisible));
    } else {
      emit(const RegistrationInitial());
    }
  }

  void validateAndProceed({
    required GlobalKey<FormState> formKey,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required BuildContext context,
  }) {
    final firstNameError = ValidationHelper.validateName(firstName);
    final lastNameError = ValidationHelper.validateName(lastName);
    final phoneError = ValidationHelper.validatePhone(phone);
    final emailError = ValidationHelper.validateEmail(email);
    final passwordError = ValidationHelper.validatePassword(password);

    if (!formKey.currentState!.validate() ||
        firstNameError != null ||
        lastNameError != null ||
        phoneError != null ||
        emailError != null ||
        passwordError != null) {
      emit(const RegistrationFailure(kDataValidation));
      showSnackBar(context, kDataValidation);
    } else {
      emit(RegistrationSuccess());
      navigateTo(context, const HomeView());
      Future.delayed(Duration.zero, () => emit(const RegistrationInitial()));
    }
  }

  void logInNavigate({required BuildContext context}) {
    emit(RegistrationSuccess());
    navigateTo(context, const UserNameSignIn());
    Future.delayed(Duration.zero, () => emit(const RegistrationInitial()));
  }
}