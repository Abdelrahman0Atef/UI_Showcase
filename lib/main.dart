import 'package:untitled/core/constants/imports.dart';

void main() {
  runApp(const MyApp());
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<SignInCubit>(
              create: (context) => SignInCubit(),
            ),
            BlocProvider<RegistrationCubit>(
              create: (context) => RegistrationCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: kFont),
            home: child,
          ),
        );
      },
      child: const UserNameSignIn(),
    );
  }
}