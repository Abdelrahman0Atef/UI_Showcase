part of '../wish_list_imports.dart';

class WishListViewModel {
  final favoritesCubit = GenericCubit<List<ApiProductModel>>([]);
  final favoritesMapCubit = GenericCubit<Map<int, bool>>({});

  final HomeViewModel homeViewModel =HomeViewModel();

  Future<void> loadFavorites() async {
    final favorites = await DBService().getFavorites();
    favoritesCubit.onUpdateData(favorites);

    final map = {for (var item in favorites) item.id!: true};
    favoritesMapCubit.onUpdateData(map);
  }

  Future<void> toggleFavorite(ApiProductModel product) async {
    final db = DBService();
    final currentMap = Map<int, bool>.from(favoritesMapCubit.state.data);

    final isFav = currentMap[product.id] ?? false;

    if (isFav) {
      await db.removeFromFavorites(product.id!);
      currentMap.remove(product.id);
    } else {
      await db.addToFavorites(product);
      currentMap[product.id!] = true;
    }

    favoritesMapCubit.onUpdateData(currentMap);
    await loadFavorites();
  }

  void checkFavorite(int productId) async {
    final isFav = await DBService().isFavorite(productId);
    final currentMap = Map<int, bool>.from(favoritesMapCubit.state.data);
    currentMap[productId] = isFav;
    favoritesMapCubit.onUpdateData(currentMap);
    print('is $isFav ************ cur $currentMap');
  }

  Future<bool> isFavorite(int id) async => favoritesMapCubit.state.data[id] ?? false;
}

