import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uk_chambers/data/Chamber.dart';
import 'package:uk_chambers/remote/repository.dart';
import 'package:uk_chambers/viewmodels/chamber_view_model.dart';

class ChambersRepoBloc {
  final repoList = BehaviorSubject<List<ChambersRepoModel>>();
  final ChambersProvider chambersRepo;

  ChambersRepoBloc({
    @required this.chambersRepo,
  }) {
    getChambers()
        .then(toViewModel)
        .then(repoList.add)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<List<Chamber>> getChambers() {
    return chambersRepo.getCurrentChambersRepos();
  }

  List<ChambersRepoModel> toViewModel(List<Chamber> dataModelList) {
    return dataModelList
        .map(
          (dataModel) => ChambersRepoModel(
            id: dataModel.id,
            name: dataModel.name,
            imageUrl: dataModel.imageUrl,
          ),
        )
        .toList(growable: false);
  }

  void dispose() {
    repoList.close();
  }
}
