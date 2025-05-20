part of '../wish_list_imports.dart';

class WishListViewModel {
  final favoritesCubit = GenericCubit<List<ApiProductModel>>([]);
  final favoritesMapCubit = GenericCubit<Map<int, bool>>({});
  final HomeViewModel homeVM = getIt<HomeViewModel>();
  final _database = getIt<DataBaseService>();
  final Map<int, GenericCubit<int>> _productCounters = {};

  GenericCubit<int> getProductCounter(ApiProductModel product) =>
      _productCounters.putIfAbsent(product.id ?? 0, () => GenericCubit<int>(0));

  Future<void> loadFavorites() async {
    final favorites = await _database.getFavorites();
    favoritesCubit.onUpdateData(favorites);
    favoritesMapCubit.onUpdateData({
      for (var item in favorites) item.id!: true,
    });
  }

  Future<void> toggleFavorite(ApiProductModel product) async {
    final currentMap = Map<int, bool>.from(favoritesMapCubit.state.data);
    final isFavorite = favoritesMapCubit.state.data[product.id] ?? false;

    currentMap[product.id!] = !isFavorite;
    favoritesMapCubit.onUpdateData(currentMap);

    if (isFavorite) {
      await _database.removeFromFavorites(product.id!);
    } else {
      await _database.addToFavorites(product);
    }

    await loadFavorites();
  }

  bool isProductFavorite(int id) => favoritesMapCubit.state.data[id] ?? false;
}
