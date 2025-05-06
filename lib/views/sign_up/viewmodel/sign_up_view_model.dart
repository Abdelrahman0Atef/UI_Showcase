part of '../sign_up_imports.dart';

class SignUpViewModel {
  final LocalStorageService _storageService = getIt<LocalStorageService>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final GenericCubit<bool> _passwordVisibleCubit = GenericCubit(false);
  final GenericCubit<bool> _hasCapitalLetterCubit = GenericCubit(false);
  final GenericCubit<bool> _hasNumberCubit = GenericCubit(false);
  final GenericCubit<bool> _hasValidLengthCubit = GenericCubit(false);
  final GenericCubit<String?> _statusMessageCubit = GenericCubit(null);

  void _dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void _togglePasswordVisibility() {
    final current = _passwordVisibleCubit.state.data;
    _passwordVisibleCubit.onUpdateData(!current);
  }

  bool get _isPasswordVisible => _passwordVisibleCubit.state.data;

  void _updatePasswordValidation(String password) {
    _hasCapitalLetterCubit.onUpdateData(
      ValidationHelper.hasCapitalLetter(password),
    );
    _hasNumberCubit.onUpdateData(ValidationHelper.hasNumber(password));
    _hasValidLengthCubit.onUpdateData(
      ValidationHelper.hasValidLength(password),
    );
  }

  bool get _isPasswordValid =>
      _hasCapitalLetterCubit.state.data &&
      _hasNumberCubit.state.data &&
      _hasValidLengthCubit.state.data;

  Future<void> _validateAndProceed({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final valid =
        _hasCapitalLetterCubit.state.data &&
        _hasNumberCubit.state.data &&
        _hasValidLengthCubit.state.data;

    if (!formKey.currentState!.validate() ||
        ValidationHelper.validateName(firstName) != null ||
        ValidationHelper.validateName(lastName) != null ||
        ValidationHelper.validatePhone(phone) != null ||
        ValidationHelper.validateEmail(email) != null ||
        ValidationHelper.validatePassword(password) != null ||
        !valid) {
      _statusMessageCubit.onUpdateData(MyStrings.thereIsAnErrorInTheData);
      return;
    }
    _saveCread();

    _statusMessageCubit.onUpdateData(null);

    if (context.mounted) {
      context.goNamed(MyRouts.home);
    }

    Future.delayed(Duration.zero, () {
      _statusMessageCubit.onUpdateData(null);
    });
  }

  void _saveCread()async{
    await _storageService.setIsChecked(SharedKeys.isRegisteredUser, true);
    await _storageService.setIsChecked(SharedKeys.emailRememberMe, true);
    await _storageService.setString(SharedKeys.firstName, _firstNameController.text);
    await _storageService.setString(SharedKeys.lastName, _lastNameController.text);
    await _storageService.setString(SharedKeys.email, _emailController.text);
    await _storageService.setString(SharedKeys.phone, _phoneController.text);
    await _storageService.setString(SharedKeys.password, _passwordController.text);

  }
  final GenericCubit<String> _firstNameCubit = GenericCubit('');
  final GenericCubit<String> _lastNameCubit = GenericCubit('');
  final GenericCubit<String> _emailCubit = GenericCubit('');
  final GenericCubit<String> _phoneCubit = GenericCubit('');

  void loadSavedCredentials() {
    _firstNameCubit.onUpdateData(_storageService.getString(SharedKeys.firstName) ?? '');
    _lastNameCubit.onUpdateData(_storageService.getString(SharedKeys.lastName) ?? '');
    _emailCubit.onUpdateData(_storageService.getString(SharedKeys.email) ?? '');
    _phoneCubit.onUpdateData(_storageService.getString(SharedKeys.phone) ?? '');
  }

  void loadSavedData() async {
    final firstName = await _storageService.getString(SharedKeys.firstName);
    final lastName = await _storageService.getString(SharedKeys.lastName);
    final email = await _storageService.getString(SharedKeys.email);
    final phone = await _storageService.getString(SharedKeys.phone);

    _firstNameCubit.onUpdateData(firstName ?? '');
    _lastNameCubit.onUpdateData(lastName ?? '');
    _emailCubit.onUpdateData(email ?? '');
    _phoneCubit.onUpdateData(phone ?? '');
  }

}
