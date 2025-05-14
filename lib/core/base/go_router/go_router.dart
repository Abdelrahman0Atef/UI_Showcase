import 'package:go_router/go_router.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/views/cart/cart_imports.dart';
import 'package:untitled/views/categorie/categorie_imports.dart';
import 'package:untitled/views/categoriesProduct/categories_product_imports.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/views/layout/layout_imports.dart';
import 'package:untitled/views/product/product_imports.dart';
import 'package:untitled/views/product_details/product_details_imports.dart';
import 'package:untitled/views/profile/profile_imports.dart';
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
      ShellRoute(
        builder: (context, state, child) => LayoutView(child: child),
        routes: [
          GoRoute(
            name: MyRouts.home,
            path: '/${MyRouts.home}',
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                name: MyRouts.search,
                path: 'search',
                builder: (context, state) => const SearchView(),
              ),
            ],
          ),
          GoRoute(
            name: MyRouts.categories,
            path: '/${MyRouts.categories}',
            builder: (context, state) => const CategoryGridView(),
            routes: [
              GoRoute(
                name: MyRouts.categoriesProducts,
                path: 'products',
                builder: (context, state) {
                  final category = state.uri.queryParameters['category'] ?? '';
                  return CategoriesProductsView(category: category);
                },
              ),
            ],
          ),
          GoRoute(
            name: MyRouts.products,
            path: '/${MyRouts.products}',
            builder: (context, state) => const ProductView(),
          ),
          GoRoute(
            name: MyRouts.cart,
            path: '/${MyRouts.cart}',
            builder: (context, state) => const CartView(),
          ),
          GoRoute(
            name: MyRouts.profile,
            path: '/${MyRouts.profile}',
            builder: (context, state) => const ProfileView(),
          ),
          GoRoute(
            name: MyRouts.productsDetails,
            path: '/${MyRouts.productsDetails}',
            builder: (context, state) {
              final product = state.extra as ProModel;
              return ProductDetailsView(product: product);
            },
          ),
        ],
      ),
    ],
  );
}