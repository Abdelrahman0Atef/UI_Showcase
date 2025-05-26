part of '../product_list_imports.dart';

class ProductListViewModel {
  final RestApiServices _apiService = getIt<RestApiServices>();

  static const int _pageSize = 20;
  static const String _categoryId = MyStrings.categoryId;
  static const String _almasryBaseUrl = MyStrings.almasryBaseUrl;
  static const String _almasryToken = MyStrings.almasryToken;
  static const String _productsEndpoint = MyStrings.productsEndpoint;

  final PagingController<int, Product> pagingController = PagingController(
    firstPageKey: 1,
  );

  ProductListViewModel() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final (newItems, isLastPage) = await _getData(pageKey);

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<(List<Product>, bool)> _getData(int pageKey) async {
    final Map<String, dynamic> queryParameters = {
      'searchCriteria[filter_groups][0][filters][0][field]': 'category_id',
      'searchCriteria[filter_groups][0][filters][0][value]': _categoryId,
      'searchCriteria[pageSize]': _pageSize.toString(),
      'searchCriteria[currentPage]': pageKey.toString(),
    };

    try {
      final dynamic responseData = await _apiService.getWithCustomAuth(
        baseUrl: _almasryBaseUrl,
        endpoint: _productsEndpoint,
        token: _almasryToken,
        queryParameters: queryParameters,
      );

      final Map<String, dynamic> data = responseData as Map<String, dynamic>;
      final List<dynamic> items = data['items'] as List<dynamic>;
      final List<Product> productList =
          items
              .map((item) => Product.fromJson(item as Map<String, dynamic>))
              .toList();

      final totalCount = data['total_count'] as int;
      final bool isLastPage =
          productList.isEmpty || (pageKey * _pageSize) >= totalCount;

      return (productList, isLastPage);
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  void retry() {
    pagingController.retryLastFailedRequest();
  }

  void dispose() {
    pagingController.dispose();
  }
}
