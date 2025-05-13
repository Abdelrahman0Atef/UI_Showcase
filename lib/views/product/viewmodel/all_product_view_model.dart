part of '../product_imports.dart';

class ProductViewModel {
  final DataSources dataSources;

  ProductViewModel(this.dataSources);

  final GenericCubit<List<ProModel>> productsCubit = GenericCubit([]);

  Future<void> getAllProducts() async {
    try {
      final products = await dataSources.getAllProduct();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }
}
