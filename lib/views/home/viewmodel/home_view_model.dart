part of '../home_imports.dart';

class HomeViewModel {
  final List<String> imageUrls = [MyAssets.card, MyAssets.ccard, MyAssets.card];
  final PageController _pageController = PageController();
  final GenericCubit<int> _pageCubit = GenericCubit(0);
  final GenericCubit<List<BlogPost>> _blogCubit = GenericCubit([]);
  final GraphQLService _graphQLService = getIt<GraphQLService>();

  Future<void> _getBlogs() async {
    try {
      const query = r'''
      query GetBlogData {
        blogPosts {
          items {
            creation_time
            featured_image
            categories {
              title
              category_id
            }
            title
            post_id
            short_content
            content
            related_products
            related_posts {
              creation_time
              featured_image
              title
              post_id
              short_content
              content
            }
          }
        }
      }
    ''';

      final data = await _graphQLService.performQuery(query: query);
      final blogsJson = data?['blogPosts']?['items'] as List<dynamic>?;

      if (blogsJson != null && blogsJson.isNotEmpty) {
        final blogs = blogsJson.map((e) => BlogPost.fromJson(e)).toList();
        _blogCubit.onUpdateData(blogs);
      } else {
        _blogCubit.onUpdateData([]);
      }
    } catch (e) {
      _blogCubit.onUpdateData([]);
    }
  }

  void changePage(int index) => _pageCubit.onUpdateData(index);

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
