import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/app_language.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locatorServices();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.supportedLocales,
      path: AppLanguage.path,
      fallbackLocale: AppLanguage.arabic,
      child: const MyApp(initialRoute: MyRouts.splash),
    ),
  );
}