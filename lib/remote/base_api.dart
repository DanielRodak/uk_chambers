import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://api.github.com/graphql',
);

final Link _link = _httpLink as Link;

GraphQLClient _client;

GraphQLClient getGraphQLClient() {
  _client ??= GraphQLClient(
    link: _link,
    cache: InMemoryCache(storageProvider: () {
      return getTemporaryDirectory(); // Provide a cache mechanism
    }),
  );

  return _client;
}