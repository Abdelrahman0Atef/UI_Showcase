import 'package:untitled/core/constants/imports.dart';

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit() : super(const SignInInitial(1, false)) {
    _loadSavedCredentials();
  }

  static const String _emailKey = emailKey;
  static const String _passwordKey = passwordKey;
  static const String _phoneKey = phoneKey;
  static const String _emailRememberMeKey = emailRememberMeKey;
  static const String _phoneRememberMeKey = phoneRememberMeKey;

  Future<void> saveEmailCredentials(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString(_emailKey, email);
      await prefs.setString(_passwordKey, password);
      await prefs.setBool(_emailRememberMeKey, true);
    } else {
      await prefs.remove(_emailKey);
      await prefs.remove(_passwordKey);
      await prefs.setBool(_emailRememberMeKey, false);
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
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString(_phoneKey, phone);
      await prefs.setBool(_phoneRememberMeKey, true);
    } else {
      await prefs.remove(_phoneKey);
      await prefs.setBool(_phoneRememberMeKey, false);
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
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey) ?? '';
    final password = prefs.getString(_passwordKey) ?? '';
    final phone = prefs.getString(_phoneKey) ?? '';
    final emailRememberMe = prefs.getBool(_emailRememberMeKey) ?? false;
    final phoneRememberMe = prefs.getBool(_phoneRememberMeKey) ?? false;

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

  void toggleLogInMethod(int index) {
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

  void registrationNavigate({required BuildContext context}) {
    emit(SignInSuccess());
    navigateTo(context, const RegistrationView() as Widget);
    Future.delayed(Duration.zero, () => _loadSavedCredentials());
  }

  void validatePhoneLogin({
    required GlobalKey<FormState> formKey,
    required String phone,
    required BuildContext context,
    required FocusNode phoneFocusNode,
  }) {
    if (!formKey.currentState!.validate()) {
      if (phone.isNotEmpty && ValidationHelper.validatePhone(phone) != null) {
        phoneFocusNode.requestFocus();
      }
    } else {
      if (state is SignInInitial) {
        final currentState = state as SignInInitial;
        savePhoneCredentials(phone, currentState.isPhoneRememberMeChecked);
      }
      emit(SignInSuccess());
      navigateTo(context, const HomeView());
    }
  }

  void validateEmailLogin({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required BuildContext context,
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
      navigateTo(context, const HomeView());
    }
  }
}
