part of '../layout_imports.dart';

class LayoutView extends StatefulWidget {
  final Widget child;

  const LayoutView({required this.child, super.key});

  @override
  State createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final List<Widget> _pages = [
    const HomeView(),
    const CategoryGridView(),
    const ProductView(),
    const CartView(),
    const ProfileView(),
  ];
  final LayoutViewModel viewModel = LayoutViewModel();
  final SearchViewModel vm = SearchViewModel();

  @override
  void initState() {
    super.initState();
    vm.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GenericCubit, GenericState>(
    bloc: viewModel._pageCubit,
    builder: (context, state) {
      final _ = context.locale;

      bool isShowingMainScreen = false;
      final String currentPath = GoRouterState.of(context).uri.path;

      if (currentPath == '/${MyRouts.home}' ||
          currentPath == '/${MyRouts.categories}' ||
          currentPath == '/${MyRouts.categoriesProducts}' ||
          currentPath == '/${MyRouts.products}' ||
          currentPath == '/${MyRouts.cart}' ||
          currentPath == '/${MyRouts.profile}') {
        isShowingMainScreen = true;
      }


      String _getAppBarTitle(String path) {
        if (path == '/${MyRouts.home}') return MyStrings.home;
        if (path == '/${MyRouts.categories}') return MyStrings.categories;
        if (path == '/${MyRouts.categoriesProducts}') return 'Products by Category';
        if (path == '/${MyRouts.products}') return MyStrings.products;
        if (path == '/${MyRouts.cart}') return MyStrings.cart;
        if (path == '/${MyRouts.profile}') return MyStrings.profile;
        return '';
      }

      return Scaffold(
        appBar: isShowingMainScreen
            ? AppBar(
          centerTitle: true,
          title: CustomText(text: _getAppBarTitle(currentPath)),
          backgroundColor: Colors.white,
          elevation: 1,
          foregroundColor: Colors.black,
        )
            : null,
        body: isShowingMainScreen ? _pages[state.data] : widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.data,
          onTap: (index) {
            switch (index) {
              case 0:
                context.pushNamed(MyRouts.home);
                break;
              case 1:
                context.pushNamed(MyRouts.categories);
                break;
              case 2:
                context.pushNamed(MyRouts.products,);
                break;
              case 3:
                context.pushNamed(MyRouts.cart,);
                break;
              case 4:
                context.pushNamed(MyRouts.profile,);
                break;
            }
            viewModel._changeScreen(index);
          },
          selectedItemColor: MyColors.red,
          unselectedItemColor: MyColors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: MyStrings.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.manage_search),
              label: MyStrings.categories,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.inventory),
              label: MyStrings.products,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: MyStrings.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: MyStrings.profile,
            ),
          ],
        ),
      );
    },
  );
}
