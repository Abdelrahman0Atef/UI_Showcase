part of '../profile_imports.dart';

class ProfileView extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const ProfileView({this.userData, super.key});

  @override
  Widget build(BuildContext context) => _ProfileViewContent(userData: userData);
}

class _ProfileViewContent extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const _ProfileViewContent({this.userData});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (context) =>
            ProfileCubit()
              ..loadUserInfo(userData)
              ..fetchAppVersion(),
    child: Scaffold(
      appBar: AppBar(title: Text(MyStrings.title), centerTitle: true),
      bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoaded) return const SizedBox.shrink();

          return NavigationBar(
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) {
              context.read<ProfileCubit>().updateSelectedIndex(index);
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home, color: MyColors.red),
                label: MyStrings.home,
              ),
              NavigationDestination(
                icon: const Icon(Icons.manage_search, color: MyColors.red),
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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          if (state is ProfileLoaded) {
            final List<Widget> screens = [
              Container(color: MyColors.green),
              Container(color: MyColors.red),
              Container(color: MyColors.grey),
              ProfileBody(
                context: context,
                state: state,
                onPressed: () => _signOut(context),
              ),
            ];
            return screens[state.selectedIndex];
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ),
  );

  void _signOut(BuildContext context) {
    const ProfileSignOutBottomSheet();
  }
}
