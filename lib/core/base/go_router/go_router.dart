import 'package:go_router/go_router.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/views/layout/layout_imports.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';
import 'package:untitled/views/splash/splash_imports.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/${MyRouts.splash}',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: MyRouts.splash,
        path: '/${MyRouts.splash}',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: MyRouts.signIn,
        path: '/${MyRouts.signIn}',
        builder: (context, state) => const SigInView(),
      ),
      GoRoute(
        name: MyRouts.signUp,
        path: '/${MyRouts.signUp}',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        name: MyRouts.home,
        path: '/${MyRouts.home}',
        builder: (context, state) => const LayoutView(),
      ),
      GoRoute(
        name: MyRouts.search,
        path: '/${MyRouts.search}',
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}
