part of '../product_imports.dart';

class ProductViewModel {
  final RestApiServices restApiServices = getIt<RestApiServices>();

  final GenericCubit<List<ApiProductModel>> productsCubit = GenericCubit([]);
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
}
