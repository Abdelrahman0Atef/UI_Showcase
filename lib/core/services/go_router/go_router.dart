import 'package:go_router/go_router.dart';
import 'package:untitled/views/home/view/home_view.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SigInView(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
