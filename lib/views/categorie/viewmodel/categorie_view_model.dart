part of '../categorie_imports.dart';

class CategoryViewModel {
  final GenericCubit<List<String>> categoryCubit = GenericCubit([]);
  final DataSources dataSource;

  CategoryViewModel(this.dataSource);

  Future<void> getCategories() async {
    try {
      final categories = await dataSource.getCategories();
      categoryCubit.onUpdateData(categories);
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
