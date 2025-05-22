import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled/core/resources/app_language.dart';
import 'package:untitled/core/services/database/database.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/my_app.dart';
import 'core/base/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DataBaseService().getFavorites();
  await locatorServices();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.supportedLocales,
      path: AppLanguage.path,
      fallbackLocale: AppLanguage.arabic,
      child: const MyApp(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}
