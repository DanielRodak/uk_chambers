import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://shrouded-savannah-89276.herokuapp.com/',
);

final Link _link = _httpLink as Link;

GraphQLClient _client;

GraphQLClient getGraphQLClient() {
  _client ??= GraphQLClient(
    link: _link,
    cache: OptimisticCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
  );

  return _client;
}
