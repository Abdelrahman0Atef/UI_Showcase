part of '../product_details_imports.dart';

class ProductDetailsViewModel {
  final CategoriesProductViewModel categoriesVM = CategoriesProductViewModel();
  final HomeViewModel homeVM = HomeViewModel();
  final RestApiServices restApiServices = getIt<RestApiServices>();

  Future<void> shareProductImageWithDio(String imageUrl) async {
    try {
      final response = await restApiServices.dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.jpg');
      await file.writeAsBytes(response.data!);

      await Share.shareXFiles([XFile(file.path)], text: MyStrings.message);
    } catch (e) {
      rethrow;
    }
  }
}
