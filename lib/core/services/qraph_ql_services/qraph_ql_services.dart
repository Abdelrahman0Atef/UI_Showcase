import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  static final GraphQLService _instance = GraphQLService._internal();

  factory GraphQLService() => _instance;

  GraphQLService._internal();

  final HttpLink _httpLink = HttpLink(
    '${dotenv.env['ALMASRY_GRAPHQL_BASE_URL']}',
  );

  GraphQLClient _getClient() => GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: _httpLink,
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
        error: ErrorPolicy.all,
      ),
      mutate: Policies(fetch: FetchPolicy.noCache, error: ErrorPolicy.all),
    ),
    queryRequestTimeout: const Duration(seconds: 15),
  );

  Future<Map<String, dynamic>?> performQuery({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    final client = _getClient();

    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.noCache,
    );

    final result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data;
  }

  Future<Map<String, dynamic>?> performMutation({
    required String mutation,
    Map<String, dynamic>? variables,
  }) async {
    final client = _getClient();

    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data;
  }
}
