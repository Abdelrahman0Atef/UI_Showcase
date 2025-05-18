part of '../layout_imports.dart';

class LayoutViewModel {
  final GenericCubit<int> _pageCubit = GenericCubit(0);

  int get currentTabIndex => _pageCubit.state.data;

  void changeTab(int index) {
    _pageCubit.onUpdateData(index);
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return MyStrings.home;
      case 1:
        return MyStrings.categories;
      case 2:
        return MyStrings.products;
      case 3:
        return MyStrings.cart;
      case 4:
        return MyStrings.profile;
      default:
        return '';
    }
  }

  bool isMainTab(String path) => path.endsWith(MyRouts.home) ||
        path.endsWith(MyRouts.categories) ||
        path.endsWith(MyRouts.products) ||
        path.endsWith(MyRouts.cart) ||
        path.endsWith(MyRouts.profile);
}
