import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/base/go_router/go_router.dart';
import 'package:untitled/core/resources/app_settings.dart';
import 'package:untitled/core/resources/my_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: AppSettings.designSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
      final easyLoading = EasyLoading.init();
      final botToast = BotToastInit();

      return MaterialApp.router(
        builder: (context, child) {
          Widget finalChild = botToast(context, child);
          finalChild = easyLoading(context, finalChild);
          return finalChild;
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(fontFamily: MyFonts.font),
        routerConfig: AppRouter.router,
      );
    },
  );

}
