import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/resources/my_fonts.dart';
import 'package:untitled/core/services/local_storage_data/setup_services.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  runApp(MyApp());
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: MyFonts.font),
          home: child,
        );
      },
      child: const SigInView(),
    );
  }
}