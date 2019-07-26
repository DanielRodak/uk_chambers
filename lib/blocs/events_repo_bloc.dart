import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uk_chambers/data/event.dart';
import 'package:uk_chambers/remote/events_repository.dart';
import 'package:uk_chambers/viewmodels/event_view_model.dart';

class EventsRepoBloc {
  final repoList = BehaviorSubject<List<EventsRepoModel>>();
  final EventsProvider eventsRepo;

  EventsRepoBloc({
    @required this.eventsRepo,
  }) {
    getChambers()
        .then(toViewModel)
        .then(repoList.add)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<List<Event>> getChambers() {
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
    repoList.close();
  }
}
