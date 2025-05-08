part of '../search_imports.dart';

class SearchViewModel {
  final GenericCubit<List<ProductModel>> _productListCubit = GenericCubit([]);
  final GenericCubit<bool> _showListCubit = GenericCubit(false);
  final GenericCubit<bool> _showClearIconCubit = GenericCubit(false);
  final TextEditingController _searchController = TextEditingController();

  static final List<ProductModel> _allProducts = [
    ProductModel(image: MyAssets.product, title: 'Panadol Extraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Amoxicillin 500mg', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Voltaren Emulgel', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Cetirizine Tablets', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Augmentin 1g', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Paracetamol Syrup', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Adol Extra', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Brufen 400mg', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Amricol Syrup', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Cataflam Tablets', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Feldene Gel', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Concor 5 Plus', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Systane Eye Drops', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Zyrtec Tablets', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Neuroton Tablets', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Ibuprofen Suspension', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Actifed Syrup', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Flagyl 500mg', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Tavanic 500', price: 245, points: 10, totalPrice: 245),
    ProductModel(image: MyAssets.product, title: 'Aerius Tablets', price: 245, points: 10, totalPrice: 245),
  ];


  void _init(){
    _searchProducts('');
    _toggleList(true);
  }

  void _incrementQuantity(ProductModel product){
    product.quantityCubit.onUpdateData(product.quantityCubit.state.data +1);
  }

  void _decrementQuantity(ProductModel product){
    if (product.quantityCubit.state.data > 0) {
      product.quantityCubit.onUpdateData(product.quantityCubit.state.data - 1);}
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      _productListCubit.onUpdateData(_allProducts);
      _showClearIconCubit.onUpdateData(false);
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
    _productListCubit.onUpdateData(_allProducts);
    _showListCubit.onUpdateData(true);
    _showClearIconCubit.onUpdateData(false);
  }
}
