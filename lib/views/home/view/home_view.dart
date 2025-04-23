part of '../home_imports.dart';

  class HomeView extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const HomeView({this.userData, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HomeCubit()..loadUserInfo(userData),
    child: const _HomeViewContent(),
  );
}

class _HomeViewContent extends StatelessWidget {
  const _HomeViewContent();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(MyStrings.title), centerTitle: true),
    bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) return const SizedBox.shrink();

        return NavigationBar(
          selectedIndex: state.selectedIndex,
          onDestinationSelected: (index) {
            context.read<HomeCubit>().updateSelectedIndex(index);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home, color: MyColors.red),
              label: MyStrings.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.category, color: MyColors.red),
              label: MyStrings.categories,
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_cart, color: MyColors.red),
              label: MyStrings.cart,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person, color: MyColors.red),
              label: MyStrings.profile,
            ),
          ],
        );
      },
    ),
    body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeLoaded) {
          final List<Widget> screens = [
            HomeBody(
              context: context,
              state: state,
              onPressed: () => _signOut(context),
            ),
            Container(color: MyColors.green),
            Container(color: MyColors.red),
            Container(color: MyColors.grey),
          ];

          return screens[state.selectedIndex];
        }

        return const Center(child: CircularProgressIndicator());
      },
    ),
  );

  void _signOut(BuildContext context) {
    context.read<HomeCubit>().signOut().then((_) {
      context.goNamed(MyRouts.signIn);
    });
  }
}