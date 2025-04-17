part of '../home_imports.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => HomeCubit()..loadUserInfo(),
      child: const _HomeViewContent(),
    );
}

class _HomeViewContent extends StatelessWidget {
  const _HomeViewContent();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(MyStrings.title),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeLoaded) {
            return HomeBody(context: context, state: state, onPressed: ()=> _logout(context));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );

  void _logout(BuildContext context) {
    context.read<HomeCubit>().logout().then((_) {
      context.goNamed(MyRouts.signInView);
    });
  }
}