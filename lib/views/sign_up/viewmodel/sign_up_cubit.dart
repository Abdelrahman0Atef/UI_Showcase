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
    // Save full name (combining first and last name)
    final fullName = '$firstName $lastName';
    await _storageService.setString(SharedKeys.userFullNameKey, fullName);

    // Save email, phone and password
    await _storageService.setString(SharedKeys.userEmailKey, email);
    await _storageService.setString(SharedKeys.userPhoneKey, phone);
    await _storageService.setString(SharedKeys.passwordKey, password);

    // Mark as registered user
    await _storageService.setIsChecked(SharedKeys.isRegisteredUserKey, true);

    // Set remember me flags
    await _storageService.setIsChecked(SharedKeys.emailRememberMeKey, true);
    await _storageService.setIsChecked(SharedKeys.phoneRememberMeKey, true);

    // Save email and phone in their respective keys as well
    await _storageService.setString(SharedKeys.emailKey, email);
    await _storageService.setString(SharedKeys.phoneKey, phone);
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
      // Save user data to local storage
      await _saveUserData(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password,
      );

      emit(SignUpSuccess());

      // Navigate to home screen after successful registration
      if (context.mounted) {
        context.goNamed(MyRouts.homeView);
      }

      Future.delayed(Duration.zero, () => emit(const SignUpInitial()));
    }
  }
}