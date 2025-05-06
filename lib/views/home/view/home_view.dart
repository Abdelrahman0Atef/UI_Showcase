part of '../home_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel vm = HomeViewModel();

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(
          title:Text(MyStrings.home) , centerTitle: true),
          body: const HomeBody()
      );
}
