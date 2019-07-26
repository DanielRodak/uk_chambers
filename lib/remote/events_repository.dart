import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uk_chambers/data/event.dart';

import 'graphql_client.dart';

class EventsProvider {
  Future<List<Event>> getCurrentChambersRepos() {
    return getGraphQLClient().query(_queryOptions()).then(_toEvents);
  }

  QueryOptions _queryOptions() {
    return QueryOptions(
      document: readEvents,
    );
  }

  List<Event> _toEvents(QueryResult queryResult) {
    if (queryResult.hasErrors) {
      throw Exception("Error during chambers call!");
    }

    final list = queryResult.data["events"] as List<dynamic>;

    return list
        .map((repoJson) => Event.fromJson(repoJson))
        .toList(growable: false);
  }
}

const String readEvents = r'''
  query ReadEvents {
    events {
      id,
      chamber,
      username,
      dateStart,
      dateEnd,
      cycle
    }
}
''';
