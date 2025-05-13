part of '../home_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final HomeViewModel vm = HomeViewModel();

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) => Container(color: MyColors.white,child: HomeBody(vm: vm));
}
