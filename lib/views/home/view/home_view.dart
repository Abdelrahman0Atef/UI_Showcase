part of '../home_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final HomeViewModel vm = HomeViewModel();

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: CustomText(text: MyStrings.home),
      centerTitle: true,
    ),
    body: HomeBody(vm: vm),
  );
}
