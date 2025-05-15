part of '../categorie_imports.dart';

class CategoryViewModel {
  final GenericCubit<List<String>> categoryCubit = GenericCubit([]);
  final RestApiServices restApiServices = getIt<RestApiServices>();

  Future<void> getCategories() async {
    try {
      final data = await restApiServices.get(
        '${MyStrings.baseUrl}/${MyStrings.apiCategories}',
      );
      final categories = List<String>.from(data);
      categoryCubit.onUpdateData(categories);
    } catch (e) {
      throw Exception(e);
    }
  }
}
