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
      throw Exception("Error during events call!");
    }

    final list = queryResult.data["events"] as List<dynamic>;

    return list
        .map((repoJson) => Event.fromJson(repoJson))
        .toList(growable: false);
  }

  Future<Event> saveEventRemote() {
    return getGraphQLClient().mutate(_writeEvent()).then(_toEvent);
  }

  MutationOptions _writeEvent() {
    return MutationOptions(
      document: writeEvent,
    );
  }

  Event _toEvent(QueryResult queryResult) {
    if (queryResult.hasErrors) {
      throw Exception("Error during event call!");
    }

    final event = queryResult.data["reserve"];

    return event
        .map((repoJson) => Event.fromJson(event));
  }
}

const String readEvents = r'''
  query ReadEvents {
    events {
      id,
      name,
      chamber,
      username,
      dateStart,
      dateEnd,
      cycle
    }
}
''';


const String writeEvent = r'''
 mutation WriteEvent {
   reserve(chamberId: "cjykddrlz001k0758a6kpt8e0", username: "leszek", cycle: false, dateStart: 70, dateEnd: 80) {
     id
   }
 }
''';
