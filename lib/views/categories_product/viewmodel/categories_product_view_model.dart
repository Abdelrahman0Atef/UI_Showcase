part of '../categories_product_imports.dart';

class CategoriesProductViewModel {
  final GenericCubit<List<ApiProductModel>> productsCubit =
      GenericCubit<List<ApiProductModel>>([]);
  final RestApiServices restApiServices = getIt<RestApiServices>();
  final HomeViewModel homeViewModel = HomeViewModel();

  Future<void> getAllProducts() async {
    try {
      final data = await restApiServices.get(MyStrings.baseUrl);
      final products = (data as List).map((e) => ApiProductModel.fromJson(e)).toList();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }

  Future<void> getProductsByCategory(String category) async {
    try {
      final data = await restApiServices.get(
        '/${MyStrings.apiCategory}/$category',
      );
      final filteredProducts =
          (data as List).map((e) => ApiProductModel.fromJson(e)).toList();
      productsCubit.onUpdateData(filteredProducts);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }
}
