part of '../home_imports.dart';

class HomeViewModel {
  final List<String> imageUrls = [MyAssets.card, MyAssets.ccard, MyAssets.card];
  final PageController _pageController = PageController();
  final GenericCubit<int> pageCubit = GenericCubit(0);

  void changePage(int index) => pageCubit.onUpdateData(index);
}
