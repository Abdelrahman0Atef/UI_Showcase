part of '../home_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final HomeViewModel vm = getIt<HomeViewModel>();

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    vm._getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Container(color: MyColors.white, child: HomeBody(vm: vm));
  }
}
