part of '../home_imports.dart';

class HomeViewModel {
  final List<String> imageUrls = [MyAssets.card, MyAssets.ccard, MyAssets.card];
  final PageController _pageController = PageController();
  final GenericCubit<int> _pageCubit = GenericCubit(0);

  void changePage(int index) => _pageCubit.onUpdateData(index);

  final Map<int, GenericCubit<int>> _productCounters = {};

  GenericCubit<int> getProductCounter(ApiProductModel product) =>
      _productCounters.putIfAbsent(product.id ?? 0, () => GenericCubit<int>(0));

  void increment(ApiProductModel product) {
    final cubit = getProductCounter(product);
    final maxCount = (product.rating?.count ?? 0) ~/ 4;
    final current = cubit.state.data;
    if (current < maxCount) {
      cubit.onUpdateData(current + 1);
    }
  }

  void decrement(ApiProductModel product) {
    final cubit = getProductCounter(product);
    final current = cubit.state.data;
    if (current > 0) {
      cubit.onUpdateData(current - 1);
    }
  }
}
