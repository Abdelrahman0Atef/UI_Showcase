import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/my_translations.dart';
import 'package:untitled/core/resources/shared_keys.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/local_storage_data/setup_services.dart';
import 'package:untitled/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  await EasyLocalization.ensureInitialized();

  final initialRoute = await determineInitialRoute();

  runApp(
    EasyLocalization(
      supportedLocales: MyTranslations.supportedLocales,
      path: MyTranslations.translationsPath,
      fallbackLocale: MyTranslations.arabicTranslations,
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

Future<String> determineInitialRoute() async {
  final storageService = getIt<LocalStorageService>();

  final emailRememberMe =
      storageService.getIsChecked(SharedKeys.emailRememberMeKey) ?? false;
  if (emailRememberMe) {
    final email = storageService.getString(SharedKeys.emailKey) ?? '';
    final password = storageService.getString(SharedKeys.passwordKey) ?? '';

    if (email.isNotEmpty && password.isNotEmpty) {
      return MyRouts.homeView;
    }
  }
  final phoneRememberMe =
      storageService.getIsChecked(SharedKeys.phoneRememberMeKey) ?? false;
  if (phoneRememberMe) {
    final phone = storageService.getString(SharedKeys.phoneKey) ?? '';

    if (phone.isNotEmpty) {
      return MyRouts.homeView;
    }
  }
  return MyRouts.signInView;
}
