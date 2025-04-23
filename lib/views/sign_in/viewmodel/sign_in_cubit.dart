part of '../sign_in_imports.dart';

class SignInCubit extends BaseCubit<SignInState> {
  final LocalStorageService _storage;

  SignInCubit(this._storage) : super(const SignInInitial(1, false)) {
    _loadSavedCredentials();
  }

  static const _emailKey = SharedKeys.email;
  static const _passwordKey = SharedKeys.password;
  static const _phoneKey = SharedKeys.phone;
  static const _emailRememberKey = SharedKeys.emailRememberMe;
  static const _phoneRememberKey = SharedKeys.phoneRememberMe;

  Future<void> _loadSavedCredentials() async {
    final email = _storage.getString(_emailKey) ?? '';
    final password = _storage.getString(_passwordKey) ?? '';
    final phone = _storage.getString(_phoneKey) ?? '';
    final emailRemember = _storage.getIsChecked(_emailRememberKey) ?? false;
    final phoneRemember = _storage.getIsChecked(_phoneRememberKey) ?? false;

    final current = state is SignInInitial ? state as SignInInitial : const SignInInitial(1, false);

    emit(current.copyWith(
      savedEmail: email,
      savedPassword: password,
      savedPhone: phone,
      isEmailRememberMeChecked: emailRemember,
      isPhoneRememberMeChecked: phoneRemember,
    ));
  }

  Future<void> saveEmailCredentials(String email, String password, bool rememberMe) async {
    if (rememberMe) {
      await _storage.setString(_emailKey, email);
      await _storage.setString(_passwordKey, password);
      await _storage.setIsChecked(_emailRememberKey, true);
    } else {
      await _storage.remove(_emailKey);
      await _storage.remove(_passwordKey);
      await _storage.setIsChecked(_emailRememberKey, false);
    }
    _loadSavedCredentials();
  }

  Future<void> savePhoneCredentials(String phone, bool rememberMe) async {
    if (rememberMe) {
      await _storage.setString(_phoneKey, phone);
      await _storage.setIsChecked(_phoneRememberKey, true);
    } else {
      await _storage.remove(_phoneKey);
      await _storage.setIsChecked(_phoneRememberKey, false);
    }
    _loadSavedCredentials();
  }

  void toggleSignInMethod(int index) {
    if (state is SignInInitial) {
      emit((state as SignInInitial).copyWith(selectedIndex: index));
    }
  }

  @override
  void togglePasswordVisibility() {
    if (state is SignInInitial) {
      final current = state as SignInInitial;
      emit(current.copyWith(passwordVisible: !current.passwordVisible));
    }
  }

  void toggleEmailRememberMe(bool value, String email, String password) {
    saveEmailCredentials(email, password, value);
  }

  void togglePhoneRememberMe(bool value, String phone) {
    savePhoneCredentials(phone, value);
  }

  void validateEmailSignIn({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
    required bool rememberMe,
  }) {
    if (!formKey.currentState!.validate()) {
      if (ValidationHelper.validateEmail(email) != null) {
        emailFocusNode.requestFocus();
      } else if (ValidationHelper.validatePassword(password) != null) {
        passwordFocusNode.requestFocus();
      }
      return;
    }

    saveEmailCredentials(email, password, rememberMe);
    emit(SignInSuccess());
  }

  void validatePhoneSignIn({
    required GlobalKey<FormState> formKey,
    required String phone,
    required FocusNode phoneFocusNode,
    required bool rememberMe,
  }) {
    if (!formKey.currentState!.validate()) {
      if (ValidationHelper.validatePhone(phone) != null) {
        phoneFocusNode.requestFocus();
      }
      return;
    }

    savePhoneCredentials(phone, rememberMe);
    emit(SignInSuccess());
  }

  void signUp() {
    emit(SignInSuccess());
    Future.delayed(Duration.zero, _loadSavedCredentials);
  }
}