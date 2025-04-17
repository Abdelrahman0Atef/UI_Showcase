import 'package:go_router/go_router.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';

class AppRouter {
  static GoRouter createRouter(String initialLocation) => GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          name: MyRouts.signInView,
          path: MyRouts.signInView,
          builder: (context, state) => const SigInView(),
        ),
        GoRoute(
          name: MyRouts.signUpView,
          path: MyRouts.signUpView,
          builder: (context, state) => const SignUpView(),
        ),
        GoRoute(
          name: MyRouts.homeView,
          path: MyRouts.homeView,
          builder: (context, state) => const HomeView(),
        ),
      ],
    );

  static final GoRouter router = createRouter(MyRouts.signInView);
}