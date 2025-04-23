part of '../sign_up_imports.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit() : super(const SignUpInitial());

  final _storageService = getIt<LocalStorageService>();

  @override
  void togglePasswordVisibility() {
    if (state is SignUpInitial) {
      final currentState = state as SignUpInitial;
      emit(SignUpInitial(
        passwordVisible: !currentState.isPasswordVisible,
        hasCapitalLetter: currentState.hasCapitalLetter,
        hasNumber: currentState.hasNumber,
        hasValidLength: currentState.hasValidLength,
      ));
    } else {
      emit(const SignUpInitial());
    }
  }

  void updatePasswordValidation(String password) {
    if (state is SignUpInitial) {
      final currentState = state as SignUpInitial;
      emit(SignUpInitial(
        passwordVisible: currentState.isPasswordVisible,
        hasCapitalLetter: ValidationHelper.hasCapitalLetter(password),
        hasNumber: ValidationHelper.hasNumber(password),
        hasValidLength: ValidationHelper.hasValidLength(password),
      ));
    } else {
      emit(SignUpInitial(
        hasCapitalLetter: ValidationHelper.hasCapitalLetter(password),
        hasNumber: ValidationHelper.hasNumber(password),
        hasValidLength: ValidationHelper.hasValidLength(password),
      ));
    }
  }

  Future<void> _saveUserData({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    final fullName = '$firstName $lastName';

    await _storageService.setString(SharedKeys.userFullName, fullName);
    await _storageService.setString(SharedKeys.userEmail, email);
    await _storageService.setString(SharedKeys.userPhone, phone);
    await _storageService.setString(SharedKeys.password, password);
    await _storageService.setIsChecked(SharedKeys.isRegisteredUser, true);
    await _storageService.setIsChecked(SharedKeys.emailRememberMe, true);
    await _storageService.setIsChecked(SharedKeys.phoneRememberMe, true);
    await _storageService.setString(SharedKeys.email, email);
    await _storageService.setString(SharedKeys.phone, phone);
  }

  void validateAndProceed({
    required GlobalKey<FormState> formKey,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final firstNameError = ValidationHelper.validateName(firstName);
    final lastNameError = ValidationHelper.validateName(lastName);
    final phoneError = ValidationHelper.validatePhone(phone);
    final emailError = ValidationHelper.validateEmail(email);
    final passwordError = ValidationHelper.validatePassword(password);
    final currentState = state is SignUpInitial ? state as SignUpInitial : const SignUpInitial();

    if (!formKey.currentState!.validate() ||
        firstNameError != null ||
        lastNameError != null ||
        phoneError != null ||
        emailError != null ||
        passwordError != null ||
        !currentState.isPasswordValid) {
      emit(SignUpFailure(MyStrings.thereIsAnErrorInTheData));
    } else {
      await _saveUserData(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password,
      );

      emit(SignUpSuccess());
      if (context.mounted) {
        context.goNamed(MyRouts.home);
      }

      Future.delayed(Duration.zero, () => emit(const SignUpInitial()));
    }
  }
}