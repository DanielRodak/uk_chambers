import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uk_chambers/data/event.dart';
import 'package:uk_chambers/remote/events_repository.dart';
import 'package:uk_chambers/viewmodels/event_view_model.dart';

class EventsRepoBloc {
  final eventsList = BehaviorSubject<List<EventsRepoModel>>();
  final EventsProvider eventsRepo;

  EventsRepoBloc({
    @required this.eventsRepo,
  }) {
    getEvents()
        .then(toViewModel)
        .then(eventsList.add)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<List<Event>> getEvents() {
    return eventsRepo.getCurrentChambersRepos();
  }

  List<EventsRepoModel> toViewModel(List<Event> dataModelList) {
    return dataModelList
        .map(
          (dataModel) => EventsRepoModel(
            id: dataModel.id,
            chamber: dataModel.chamber,
            username: dataModel.username,
            dateStart: dataModel.dateStart,
            dateEnd: dataModel.dateEnd,
            cycle: dataModel.cycle,
          ),
        )
        .toList(growable: false);
  }

  void dispose() {
    eventsList.close();
  }
}

class EventRepoBloc {
  final event = BehaviorSubject<EventRepoModel>();
  final EventsProvider eventRepo;

  EventRepoBloc({
    @required this.eventRepo,
  }) {
    getEvents()
        .then(toViewModel)
        .then(event.add)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<Event> getEvents() {
    return eventRepo.saveEventRemote();
  }

  EventRepoModel toViewModel(Event dataModelList) {
    return EventRepoModel(id: dataModelList.id,);
  }

  void dispose() {
    event.close();
  }
}
