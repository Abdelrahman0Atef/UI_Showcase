part of '../sign_in_imports.dart';

class SignInViewModel {
  final GenericCubit<bool> _emailRememberCubit = GenericCubit(false);
  final GenericCubit<bool> _phoneRememberCubit = GenericCubit(false);

  final GenericCubit<String> _emailCubit = GenericCubit('');
  final GenericCubit<String> _passwordCubit = GenericCubit('');
  final GenericCubit<String> _phoneCubit = GenericCubit('');

  final GenericCubit<String?> _statusMessageCubit = GenericCubit(null);
  final LocalStorageService _storage = getIt<LocalStorageService>();
  final GenericCubit<int> _signInMethodCubit = GenericCubit(1);
  final GenericCubit<bool> _togglePasswordVisibilityCubit = GenericCubit(false);

  void _initLoadCredential() {
    if (_emailRememberCubit == true) {
      _loadSavedCredentialsEmail();
    } else if (_phoneRememberCubit == true) {
      _loadSavedCredentialsPhone();
    } else {}
  }

  void _loadSavedCredentialsEmail() {
    _emailCubit.onUpdateData(_storage.getString(SharedKeys.email) ?? '');
    _passwordCubit.onUpdateData(_storage.getString(SharedKeys.password) ?? '');

    _emailRememberCubit.onUpdateData(
      _storage.getIsChecked(SharedKeys.emailRememberMe) ?? false,
    );
  }

  void _loadSavedCredentialsPhone() {
    _phoneCubit.onUpdateData(_storage.getString(SharedKeys.phone) ?? '');

    _phoneRememberCubit.onUpdateData(
      _storage.getIsChecked(SharedKeys.phoneRememberMe) ?? false,
    );
  }

  void _saveEmailCredentials(
    String email,
    String password,
    bool rememberMe,
  ) async {
      await _storage.setString(SharedKeys.email, email);
      await _storage.setString(SharedKeys.password, password);
      if(rememberMe == false){
      await _storage.remove(SharedKeys.email);
      await _storage.remove(SharedKeys.password);}
      if(rememberMe == true) {
        await _storage.setIsChecked(SharedKeys.emailRememberMe, true);
      }

    if (rememberMe == true) {
      _loadSavedCredentialsEmail();
    }
  }

  void _deleteEmailCredentials(bool rememberMe)async{
    if(rememberMe == false)
      {
        await _storage.remove(SharedKeys.email);
        await _storage.remove(SharedKeys.password);
        await _storage.setIsChecked(SharedKeys.emailRememberMe, false);
      }
  }

  void _savePhoneCredentials(String phone, bool rememberMe) async {
      await _storage.setString(SharedKeys.phone, phone);
      if(rememberMe == false){
        await _storage.remove(SharedKeys.phone);}
      if (rememberMe) {
      await _storage.setIsChecked(SharedKeys.phoneRememberMe, true);
    }
    if (rememberMe == true) {
      _loadSavedCredentialsPhone();
    }
  }

  void _deletePhoneCredentials(bool rememberMe)async{
    if(rememberMe == false)
    {
      await _storage.remove(SharedKeys.phone);
      await _storage.setIsChecked(SharedKeys.phoneRememberMe, false);
    }
  }

  void _toggleEmailRememberMe(bool value, String email, String password) {
    if(value == true) {
      _saveEmailCredentials(email, password, value);
    }else{
      _deleteEmailCredentials(value);
    }
  }

  void _togglePhoneRememberMe(bool value, String phone) {
    if(value == true) {
    _savePhoneCredentials(phone, value);
  }else{
    _deletePhoneCredentials(value);}
  }

  void _validateEmailSignIn({
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
      _statusMessageCubit.onUpdateData(null);
      return;
    }

    _saveEmailCredentials(email, password, rememberMe);
    _statusMessageCubit.onUpdateData(null);
  }

  void _validatePhoneSignIn({
    required GlobalKey<FormState> formKey,
    required String phone,
    required FocusNode phoneFocusNode,
    required bool rememberMe,
  }) {
    if (!formKey.currentState!.validate()) {
      if (ValidationHelper.validatePhone(phone) != null) {
        phoneFocusNode.requestFocus();
      }
      _statusMessageCubit.onUpdateData(null);
      return;
    }

    _savePhoneCredentials(phone, rememberMe);
    _statusMessageCubit.onUpdateData(null);
  }

  void _signUp() {
    _statusMessageCubit.onUpdateData(null);
    Future.delayed(Duration.zero, _loadSavedCredentialsEmail);
  }

  void _toggleSignInMethod(int index) {
    _signInMethodCubit.onUpdateData(index);
  }

  void _togglePasswordVisibility() {
    final current = _togglePasswordVisibilityCubit.state.data;
    _togglePasswordVisibilityCubit.onUpdateData(!current);
  }

  bool get _isPasswordVisible => _togglePasswordVisibilityCubit.state.data;
}
