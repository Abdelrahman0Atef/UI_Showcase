part of '../splash_imports.dart';

class SplashViewModel {
  final BuildContext context;

  SplashViewModel(this.context);

  void handleNavigation() {
    Timer(const Duration(seconds: 2), () async {
      final storageService = getIt<LocalStorageService>();

      final isRegistered = storageService.getIsChecked(
        SharedKeys.isRegisteredUser,
      );
      if (isRegistered == true) {
        context.goNamed(MyRouts.home);
      } else {
        context.goNamed(MyRouts.signIn);
      }
    });
  }
}
