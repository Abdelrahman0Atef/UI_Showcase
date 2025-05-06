part of '../layout_imports.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final List<Widget> _pages = [
    const HomeView(),
    Scaffold(
      appBar: AppBar(title: Text(MyStrings.categories), centerTitle: true),
      body: Container(color: MyColors.green),
    ),
    Scaffold(
      appBar: AppBar(title: Text(MyStrings.cart), centerTitle: true),
      body: Container(color: MyColors.red),
    ),
    const ProfileView(),
  ];

  final LayoutViewModel viewModel = LayoutViewModel();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GenericCubit<int>, GenericState<int>>(
        bloc: viewModel._pageCubit,
        builder: (context, state) {
          final _ = context.locale;
          return Scaffold(
            body: IndexedStack(index: state.data, children: _pages),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.data,
              onTap: (index) {
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
