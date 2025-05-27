part of '../categories_product_imports.dart';

class CategoriesProductViewModel {
  final GenericCubit<List<ApiProductModel>> productsCubit =
      GenericCubit<List<ApiProductModel>>([]);
  final RestApiServices restApiServices = getIt<RestApiServices>();
  final HomeViewModel homeVm = getIt<HomeViewModel>();

  Future<void> getAllProducts() async {
    try {
      final data = await restApiServices.get(dotenv.env['FAKE_BASE_URL'] as String);
      final products = (data as List).map((e) => ApiProductModel.fromJson(e)).toList();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }

  Future<void> getProductsByCategory(String category) async {
    try {
      final data = await restApiServices.get(
        '/${ApiPath.fakeApiCategory}/$category',
      );
      final filteredProducts =
          (data as List).map((e) => ApiProductModel.fromJson(e)).toList();
      productsCubit.onUpdateData(filteredProducts);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }

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
