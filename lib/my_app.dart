import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/base/go_router/go_router.dart';
import 'package:untitled/core/resources/app_settings.dart';
import 'package:untitled/core/resources/my_fonts.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: AppSettings.designSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder:
        (_, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(fontFamily: MyFonts.font),
          routerConfig: AppRouter.router,
        ),
  );
}
