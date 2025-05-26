part of '../product_details_imports.dart';

class ProductDetailsViewModel {
  final CategoriesProductViewModel categoriesVM = CategoriesProductViewModel();
  final HomeViewModel homeVM = getIt<HomeViewModel>();
  final RestApiServices restApiServices = getIt<RestApiServices>();
  final WishListViewModel wishListVm = getIt<WishListViewModel>();

  Future<void> shareProductImageWithDio(String imageUrl) async {
    try {
      final response = await restApiServices.dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );


      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.jpg');
      await file.writeAsBytes(response.data!);

      final params = ShareParams(
        text: MyStrings.message,
        files: [XFile(file.path)],
      );

      await SharePlus.instance.share(params);
      //await Share.shareXFiles([XFile], text: MyStrings.message);
    } catch (e) {
      rethrow;
    }
  }
}
