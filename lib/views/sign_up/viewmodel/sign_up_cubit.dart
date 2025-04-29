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

  Future<void> _saveMinimalUserData() async {
    await _storageService.setIsChecked(SharedKeys.isRegisteredUser, true);
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
      await _saveMinimalUserData();

      // Create userData to pass to profile screen instead of storing it
      final Map<String, dynamic> userData = {
        SharedKeys.isRegisteredUser: true,
        SharedKeys.userFullName: '$firstName $lastName',
        SharedKeys.email: email,
        SharedKeys.phone: phone,
        SharedKeys.userEmail: email,
        SharedKeys.userPhone: phone,
      };

      emit(SignUpSuccess());
      if (context.mounted) {
        context.goNamed(MyRouts.home, extra: userData);
      }

      Future.delayed(Duration.zero, () => emit(const SignUpInitial()));
    }
  }
}