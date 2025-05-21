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

  Future<String> submitContactForm(
    String name,
    String email,
    String comment,
    String? telephone,
  ) async {
    final client = getClient();

    final MutationOptions options = MutationOptions(
      document: gql(r'''
        mutation SubmitContactForm($name: String!, $email: String!, $comment: String!, $telephone: String) {
          contactUs(input: {name: $name, email: $email, comment: $comment, telephone: $telephone}) {
            status
          }
        }
      '''),
      variables: <String, dynamic>{
        'name': name,
        'email': email,
        'comment': comment,
        'telephone': telephone,
      },
    );

    try {
      final result = await client.mutate(options);

      if (result.hasException) {
        throw Exception('Error submitting contact form');
      }

      final status = result.data?['contactUs']['status'];
      return status == true ? 'Success' : 'Error';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
