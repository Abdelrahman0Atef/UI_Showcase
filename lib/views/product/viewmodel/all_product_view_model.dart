part of '../product_imports.dart';

class ProductViewModel {
  final RestApiServices restApiServices = getIt<RestApiServices>();

  final GenericCubit<List<ProModel>> productsCubit = GenericCubit([]);
  final HomeViewModel homeViewModel = HomeViewModel();

  Future<void> getAllProducts() async {
    try {
      final data = await restApiServices.get(MyStrings.baseUrl);
      final products = (data as List).map((e) => ProModel.fromJson(e)).toList();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }
}
