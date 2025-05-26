part of '../product_imports.dart';

class ProductsViewModel {
  final RestApiServices restApiServices = getIt<RestApiServices>();
  final GenericCubit<List<ApiProductModel>> productsCubit = GenericCubit([]);
  final HomeViewModel homeViewModel = getIt<HomeViewModel>();
  final _database = getIt<DataBaseService>();
  final favoritesCubit = GenericCubit<List<ApiProductModel>>([]);
  final favoritesMapCubit = GenericCubit<Map<int, bool>>({});


  Future<void> loadFavorites() async {
    final favorites = await _database.getFavorites();
    favoritesCubit.onUpdateData(favorites);
    favoritesMapCubit.onUpdateData({
      for (var item in favorites) item.id!: true,
    });
  }

  Future<void> getAllProducts() async {
    try {
      final data = await restApiServices.get(MyStrings.baseUrl);
      final products = (data as List).map((e) => ApiProductModel.fromJson(e)).toList();
      productsCubit.onUpdateData(products);
    } catch (e) {
      productsCubit.onUpdateData([]);
    }
  }

  bool isProductFavorite(int id) =>  favoritesMapCubit.state.data[id] ?? false;

}

