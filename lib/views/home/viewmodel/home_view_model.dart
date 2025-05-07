part of '../home_imports.dart';

class HomeViewModel {
  final GenericCubit<List<ProductModel>> _productListCubit = GenericCubit([]);
  final GenericCubit<bool> _showListCubit = GenericCubit(false);
  final GenericCubit<bool> _showClearIconCubit = GenericCubit(false);

  final List<ProductModel> _allProducts = [
    ProductModel(image: MyAssets.product, title: 'vdfgfdgdffffffffffffffff', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'nghnhgjjjjjjjjjjjjjjjjjjjjjjjj', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'dfddfgfgdfgdfgdfgdfgdfgfdg', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'hghfdfhyyyyyyyyyyyyyyyyyyyy', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'gfhfghfghfghfghfghfghfghfghfg', price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: MyStrings.product, price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: MyStrings.product, price: 245,points: 10,totalPrice: 245),
    ProductModel(image: MyAssets.product, title: MyStrings.product, price: 245,points: 10,totalPrice: 245),
  ];

  void _searchProducts(String query) {
    if (query.isEmpty) {
      _productListCubit.onUpdateData([]);
      return;
    }
    final filtered = _allProducts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    _productListCubit.onUpdateData(filtered);
    _showClearIconCubit.onUpdateData(query.isNotEmpty);
  }

  void _toggleList(bool show) {
    _showListCubit.onUpdateData(show);
  }

  void _clearSearchResults() {
    _productListCubit.onUpdateData([]);
    _showListCubit.onUpdateData(true);
    _showClearIconCubit.onUpdateData(false);
  }
}

