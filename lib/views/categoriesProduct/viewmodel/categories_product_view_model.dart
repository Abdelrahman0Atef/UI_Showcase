part of '../categories_product_imports.dart';

class CategoriesProductViewModel {
  final DataSources dataSources;
  final GenericCubit<ProModel> productCubit = GenericCubit<ProModel>(ProModel());
  final GenericCubit<List<ProModel>> productsCubit = GenericCubit<List<ProModel>>([]);

  CategoriesProductViewModel(this.dataSources) {}

  Future<void> getAllProducts() async {
    try {
      final products = await dataSources.getAllProduct();
      productsCubit.onUpdateData(products);
    } catch (e) {    }
  }

  Future<void> getProductsByCategory(String category) async {
    try {
      final allProducts = await dataSources.getAllProduct();
      final filteredProducts = allProducts.where(
              (product) => product.category?.toLowerCase() == category.toLowerCase()
      ).toList();
      productsCubit.onUpdateData(filteredProducts);
    } catch (e) {    }
  }
}