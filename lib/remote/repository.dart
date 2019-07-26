import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uk_chambers/data/Chamber.dart';

import 'graphql_client.dart';

class ChambersProvider {
  Future<List<Chamber>> getCurrentChambersRepos() {
    return getGraphQLClient().query(_queryOptions()).then(_toChambers);
  }

  QueryOptions _queryOptions() {
    return QueryOptions(
      document: readChambers,
    );
  }

  List<Chamber> _toChambers(QueryResult queryResult) {
    if (queryResult.hasErrors) {
      throw Exception("Error during chambers call!");
    }

    final list = queryResult.data["chambers"] as List<dynamic>;

    return list
        .map((repoJson) => Chamber.fromJson(repoJson))
        .toList(growable: false);
  }
}

const String readChambers = r'''
  query ReadChambers {
    chambers {
      id,
      name,
      imageUrl
    }
}
''';
