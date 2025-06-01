import 'package:go_router/go_router.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';
import 'package:untitled/core/resources/api_path.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/views/cart/cart_imports.dart';
import 'package:untitled/views/categorie/categorie_imports.dart';
import 'package:untitled/views/categories_product/categories_product_imports.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/views/layout/layout_imports.dart';
import 'package:untitled/views/prayer_time_reminder/prayer_time_reminder_imports.dart';
import 'package:untitled/views/product/product_imports.dart';
import 'package:untitled/views/product_details/product_details_imports.dart';
import 'package:untitled/views/product_list/product_list_imports.dart';
import 'package:untitled/views/profile/profile_imports.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';
import 'package:untitled/views/splash/splash_imports.dart';
import 'package:untitled/views/wish_list/wish_list_imports.dart';
import '../../../views/contact_us/contact_us_imports.dart';

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
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => LayoutView(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRouts.home}',
                name: MyRouts.home,
                builder: (context, state) => const HomeView(),
                routes: [
                  GoRoute(
                    path: MyRouts.search,
                    name: MyRouts.search,
                    builder: (context, state) => const SearchView(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRouts.categories}',
                name: MyRouts.categories,
                builder: (context, state) => const CategoryGridView(),
                routes: [
                  GoRoute(
                    path: MyRouts.categoriesProducts,
                    name: MyRouts.categoriesProducts,
                    builder: (context, state) {
                      final category =
                          state.uri.queryParameters[ApiPath.fakeApiCategory] ??
                          '';
                      return CategoriesProductsView(category: category);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRouts.products}',
                name: MyRouts.products,
                builder: (context, state) => const ProductsView(),
                routes: [
                  GoRoute(
                    path: MyRouts.productsDetails,
                    name: MyRouts.productsDetails,
                    builder: (context, state) {
                      final product = state.extra as ApiProductModel;
                      return ProductDetailsView(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRouts.cart}',
                name: MyRouts.cart,
                builder: (context, state) => const CartView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRouts.profile}',
                name: MyRouts.profile,
                builder: (context, state) => const ProfileView(),
                routes: [
                  GoRoute(
                    path: '/${MyRouts.wishList}',
                    name: MyRouts.wishList,
                    builder: (context, state) => const WishListView(),
                  ),
                  GoRoute(
                    path: '/${MyRouts.contactUs}',
                    name: MyRouts.contactUs,
                    builder: (context, state) =>  const ContactUsView(),
                  ),
                  GoRoute(
                    path: '/${MyRouts.productList}',
                    name: MyRouts.productList,
                    builder: (context, state) =>  const ProductListView(),
                  ),
                  GoRoute(
                    path: '/${MyRouts.prayerTime}',
                    name: MyRouts.prayerTime,
                    builder: (context, state) =>  const PrayerTimeReminder(),
                  ),
                ]
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
