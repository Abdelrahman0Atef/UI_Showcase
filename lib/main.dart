import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/resources/my_fonts.dart';
import 'package:untitled/core/services/go_router/go_router.dart';
import 'package:untitled/core/services/local_storage_data/setup_services.dart';
import 'package:untitled/generated/codegen_loader.g.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        startLocale: Locale('ar'),
        assetLoader: CodegenLoader(),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(fontFamily: MyFonts.font),
            routerConfig: AppRouter.router,
        );
      },
      child: const SigInView(),
    );
  }
}
