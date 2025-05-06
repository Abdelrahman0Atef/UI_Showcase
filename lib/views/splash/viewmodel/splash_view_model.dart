part of '../splash_imports.dart';

class SplashViewModel {
  final BuildContext context;

  SplashViewModel(this.context);

  void handleNavigation() {
    Timer(const Duration(seconds: 2), () async {
      final storageService = getIt<LocalStorageService>();

      final isRegistered = storageService.getIsChecked(SharedKeys.isRegisteredUser,);
      final isPhoneRememberMe = storageService.getIsChecked(SharedKeys.phoneRememberMe,);
      final isEmailRememberMe = storageService.getIsChecked(SharedKeys.emailRememberMe,);
      final email = storageService.getString(SharedKeys.email);
      final phone = storageService.getString(SharedKeys.phone);

      if (isRegistered == true &&
          (isPhoneRememberMe == true || isEmailRememberMe == true) &&
          (email?.isNotEmpty == true || phone?.isNotEmpty == true)) {
        context.goNamed(MyRouts.home);
      } else {
        context.goNamed(MyRouts.signIn);
      }
    });
  }
}
