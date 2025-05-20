import 'package:graphql/client.dart';
import 'package:untitled/core/models/blogs_model/blogs_model.dart';

class GraphQLService {
  final HttpLink httpLink = HttpLink(
    'https://backend.almasrypharmacy.com/graphql',
  );

  GraphQLClient getClient() => GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  );

  Future<List<BlogPost>> fetchBlogData() async {
    final client = getClient();

    final QueryOptions options = QueryOptions(
      document: gql(r'''
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
    '''),
    );

    try {
      final result = await client.query(options);

      if (result.hasException) {
        throw Exception('Error fetching blog data');
      }

      final blogData = result.data?['blogPosts'];
      if (blogData == null || blogData['items'] == null) {
        return [];
      }

      final blogsJson = blogData['items'] as List<dynamic>;

      return blogsJson.map((e) => BlogPost.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
