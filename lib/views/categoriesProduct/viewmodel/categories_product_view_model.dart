part of '../categories_product_imports.dart';

class CategoriesProductViewModel {
  final GenericCubit<ProModel> productCubit = GenericCubit<ProModel>(ProModel());
  final GenericCubit<List<ProModel>> productsCubit = GenericCubit<List<ProModel>>([]);
  final RestApiServices restApiServices = getIt<RestApiServices>();
  final HomeViewModel homeViewModel = HomeViewModel();


  Future<void> getAllProducts() async {
    try {
      final data = await restApiServices.get(restApiServices.baseUrl);
      final products = (data as List).map((e) => ProModel.fromJson(e)).toList();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }

  Future<void> getProductsByCategory(String category) async {
    try {
      final data = await restApiServices.get('${restApiServices.baseUrl}/category/$category');
      final filteredProducts = (data as List).map((e) => ProModel.fromJson(e)).toList();
      productsCubit.onUpdateData(filteredProducts);
    } catch (e) {
      try {
        final allData = await restApiServices.get(restApiServices.baseUrl);
        final allProducts = (allData as List).map((e) => ProModel.fromJson(e)).toList();
        final filtered = allProducts
            .where((product) => product.category?.toLowerCase() == category.toLowerCase())
            .toList();
        productsCubit.onUpdateData(filtered);
      } catch (_) {
        productsCubit.onUpdateData([]);
      }
    }
  }
}
