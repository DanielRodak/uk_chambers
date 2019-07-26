import 'package:meta/meta.dart';
import 'package:uk_chambers/data/chamber.dart';

class EventsRepoModel {
  final String id;
  final Chamber chamber;
  final String username;
  final int dateStart;
  final int dateEnd;
  final bool cycle;

  EventsRepoModel({
    @required this.id,
    @required this.chamber,
    @required this.username,
    @required this.dateStart,
    @required this.dateEnd,
    @required this.cycle,
  });
}

class EventRepoModel {
  final String id;

  EventRepoModel({
    @required this.id,
  });
}