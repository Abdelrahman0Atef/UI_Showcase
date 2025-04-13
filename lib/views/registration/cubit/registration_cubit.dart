import 'package:untitled/core/constants/imports.dart';

class RegistrationCubit extends BaseCubit<RegistrationState> {
  RegistrationCubit() : super(const RegistrationInitial());

  @override
  void togglePasswordVisibility() {
    if (state is RegistrationInitial) {
      final currentState = state as RegistrationInitial;
      emit(RegistrationInitial(
        passwordVisible: !currentState.isPasswordVisible,
        hasCapitalLetter: currentState.hasCapitalLetter,
        hasNumber: currentState.hasNumber,
        hasValidLength: currentState.hasValidLength,
      ));
    } else {
      emit(const RegistrationInitial());
    }
  }

  void updatePasswordValidation(String password) {
    if (state is RegistrationInitial) {
      final currentState = state as RegistrationInitial;
      emit(RegistrationInitial(
        passwordVisible: currentState.isPasswordVisible,
        hasCapitalLetter: ValidationHelper.hasCapitalLetter(password),
        hasNumber: ValidationHelper.hasNumber(password),
        hasValidLength: ValidationHelper.hasValidLength(password),
      ));
    } else {
      emit(RegistrationInitial(
        hasCapitalLetter: ValidationHelper.hasCapitalLetter(password),
        hasNumber: ValidationHelper.hasNumber(password),
        hasValidLength: ValidationHelper.hasValidLength(password),
      ));
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
    final currentState = state is RegistrationInitial ? state as RegistrationInitial : const RegistrationInitial();

    if (!formKey.currentState!.validate() ||
        firstNameError != null ||
        lastNameError != null ||
        phoneError != null ||
        emailError != null ||
        passwordError != null ||
        !currentState.isPasswordValid) {
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