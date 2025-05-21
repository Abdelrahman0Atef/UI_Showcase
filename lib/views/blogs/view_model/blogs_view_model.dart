part of '../blogs.imports.dart';

class BlogsViewModel {
  final GenericCubit<List<BlogPost>> blogCubit = GenericCubit([]);
  final GraphQLService graphQLService = getIt<GraphQLService>();

  Future<void> getBlogs() async {
    try {
      final blogs = await graphQLService.fetchBlogData();
      blogCubit.onUpdateData(blogs);
    } catch (e) {
      throw Exception(e);
    }
  }
}
