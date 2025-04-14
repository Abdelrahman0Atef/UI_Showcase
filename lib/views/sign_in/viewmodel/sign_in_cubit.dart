part of '../sign_in_imports.dart';

class SignInCubit extends BaseCubit<SignInState> {
  final LocalStorageService _storage;

  SignInCubit(this._storage) : super(const SignInInitial(1, false)) {
    _loadSavedCredentials();
  }

  static const String _emailKey = MyStrings.emailKey;
  static const String _passwordKey = MyStrings.passwordKey;
  static const String _phoneKey = MyStrings.phoneKey;
  static const String _emailRememberMeKey = MyStrings.emailRememberMeKey;
  static const String _phoneRememberMeKey = MyStrings.phoneRememberMeKey;

  Future<void> saveEmailCredentials(
      String email,
      String password,
      bool rememberMe,
      ) async {
    if (rememberMe) {
      await _storage.setString(_emailKey, email);
      await _storage.setString(_passwordKey, password);
      await _storage.setIsChecked(_emailRememberMeKey, true);
    } else {
      await _storage.remove(_emailKey);
      await _storage.remove(_passwordKey);
      await _storage.setIsChecked(_emailRememberMeKey, false);
    }

    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          currentState.selectedIndex,
          currentState.passwordVisible,
          isEmailRememberMeChecked: rememberMe,
          isPhoneRememberMeChecked: currentState.isPhoneRememberMeChecked,
          savedEmail: rememberMe ? email : '',
          savedPassword: rememberMe ? password : '',
          savedPhone: currentState.savedPhone,
        ),
      );
    }
  }

  Future<void> savePhoneCredentials(String phone, bool rememberMe) async {
    if (rememberMe) {
      await _storage.setString(_phoneKey, phone);
      await _storage.setIsChecked(_phoneRememberMeKey, true);
    } else {
      await _storage.remove(_phoneKey);
      await _storage.setIsChecked(_phoneRememberMeKey, false);
    }

    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          currentState.selectedIndex,
          currentState.passwordVisible,
          isEmailRememberMeChecked: currentState.isEmailRememberMeChecked,
          isPhoneRememberMeChecked: rememberMe,
          savedEmail: currentState.savedEmail,
          savedPassword: currentState.savedPassword,
          savedPhone: rememberMe ? phone : '',
        ),
      );
    }
  }

  Future<void> _loadSavedCredentials() async {
    final email = _storage.getString(_emailKey) ?? '';
    final password = _storage.getString(_passwordKey) ?? '';
    final phone = _storage.getString(_phoneKey) ?? '';
    final emailRememberMe = _storage.getIsChecked(_emailRememberMeKey) ?? false;
    final phoneRememberMe = _storage.getIsChecked(_phoneRememberMeKey) ?? false;

    emit(
      SignInInitial(
        1,
        false,
        isEmailRememberMeChecked: emailRememberMe,
        isPhoneRememberMeChecked: phoneRememberMe,
        savedEmail: email,
        savedPassword: password,
        savedPhone: phone,
      ),
    );
  }

  void toggleSignInMethod(int index) {
    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          index,
          currentState.passwordVisible,
          isEmailRememberMeChecked: currentState.isEmailRememberMeChecked,
          isPhoneRememberMeChecked: currentState.isPhoneRememberMeChecked,
          savedEmail: currentState.savedEmail,
          savedPassword: currentState.savedPassword,
          savedPhone: currentState.savedPhone,
        ),
      );
    } else {
      emit(const SignInInitial(1, false));
    }
  }

  @override
  void togglePasswordVisibility() {
    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          currentState.selectedIndex,
          !currentState.passwordVisible,
          isEmailRememberMeChecked: currentState.isEmailRememberMeChecked,
          isPhoneRememberMeChecked: currentState.isPhoneRememberMeChecked,
          savedEmail: currentState.savedEmail,
          savedPassword: currentState.savedPassword,
          savedPhone: currentState.savedPhone,
        ),
      );
    } else {
      emit(const SignInInitial(1, false));
    }
  }

  void toggleEmailRememberMe(bool value, String email, String password) {
    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          currentState.selectedIndex,
          currentState.passwordVisible,
          isEmailRememberMeChecked: value,
          isPhoneRememberMeChecked: currentState.isPhoneRememberMeChecked,
          savedEmail: value ? email : currentState.savedEmail,
          savedPassword: value ? password : currentState.savedPassword,
          savedPhone: currentState.savedPhone,
        ),
      );
    } else {
      emit(SignInInitial(1, false, isEmailRememberMeChecked: value));
    }
  }

  void togglePhoneRememberMe(bool value, String phone) {
    if (state is SignInInitial) {
      final currentState = state as SignInInitial;
      emit(
        SignInInitial(
          currentState.selectedIndex,
          currentState.passwordVisible,
          isEmailRememberMeChecked: currentState.isEmailRememberMeChecked,
          isPhoneRememberMeChecked: value,
          savedEmail: currentState.savedEmail,
          savedPassword: currentState.savedPassword,
          savedPhone: value ? phone : currentState.savedPhone,
        ),
      );
    } else {
      emit(SignInInitial(1, false, isPhoneRememberMeChecked: value));
    }
  }

  void signUp() {
    emit(SignInSuccess());
    Future.delayed(Duration.zero, () => _loadSavedCredentials());
  }

  void validatePhoneSignIn({
    required GlobalKey<FormState> formKey,
    required String phone,
    required FocusNode phoneFocusNode,
    required bool rememberMe,
  }) {
    if (!formKey.currentState!.validate()) {
      if (phone.isNotEmpty && ValidationHelper.validatePhone(phone) != null) {
        phoneFocusNode.requestFocus();
      }
    } else {
      savePhoneCredentials(phone, rememberMe);
      emit(SignInSuccess());
    }
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
      if (email.isNotEmpty && ValidationHelper.validateEmail(email) != null) {
        emailFocusNode.requestFocus();
      } else if (password.isNotEmpty &&
          ValidationHelper.validatePassword(password) != null) {
        passwordFocusNode.requestFocus();
      }
    } else {
      saveEmailCredentials(email, password, rememberMe);
      emit(SignInSuccess());
    }
  }
}