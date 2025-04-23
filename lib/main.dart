import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/app_language.dart';
import 'package:untitled/core/resources/shared_keys.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locatorServices();
  await EasyLocalization.ensureInitialized();

  final initialRoute = await determineInitialRoute();

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.supportedLocales,
      path: AppLanguage.path,
      fallbackLocale: AppLanguage.arabic,
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

Future<String> determineInitialRoute() async {
  final storageService = getIt<LocalStorageService>();

  final emailRememberMe =
      storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;
  if (emailRememberMe) {
    final email = storageService.getString(SharedKeys.email) ?? '';
    final password = storageService.getString(SharedKeys.password) ?? '';

    if (email.isNotEmpty && password.isNotEmpty) {
      return MyRouts.home;
    }
  }

  final phoneRememberMe =
      storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;
  if (phoneRememberMe) {
    final phone = storageService.getString(SharedKeys.phone) ?? '';

    if (phone.isNotEmpty) {
      return MyRouts.home;
    }
  }

  return MyRouts.splash;
}
