part of '../home_imports.dart';

class HomeViewModel {
  final SearchViewModel sVM = SearchViewModel();
  final List<String> imageUrls = [MyAssets.card, MyAssets.ccard, MyAssets.card];
  final PageController _pageController = PageController();
  final GenericCubit<int> _pageCubit = GenericCubit(0);

  void changePage(int index) => _pageCubit.onUpdateData(index);
}
