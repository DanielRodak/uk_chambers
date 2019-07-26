import 'package:flutter/material.dart';
import 'package:uk_chambers/blocs/chambers_repo_bloc.dart';
import 'package:uk_chambers/remote/repository.dart';
import 'package:provider/provider.dart';
import 'package:uk_chambers/viewmodels/chamber_view_model.dart';

import 'booking_screen.dart';
import 'data/chamber.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GraphQL Demo'),
        ),
        body: Provider<ChambersRepoBloc>(
          builder: (_) =>
              ChambersRepoBloc(
                chambersRepo: ChambersProvider(),
              ),
          dispose: (_, bloc) => bloc.dispose(),
          child: ChambersRepoWidget(),
        ),
      ),
    );
  }
}

class ChambersRepoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<ChambersRepoBloc>(context).repoList,
      builder: (context, repoSnapshot) {
        if (!repoSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final list = repoSnapshot.data as List<ChambersRepoModel>;

        return new ChambersList(list);
      },
    );
  }
}

class ChambersList extends StatefulWidget {
  List<ChambersRepoModel> chambersList;

  ChambersList(this.chambersList);

  @override
  ChambersListState createState() => ChambersListState(chambersList);
}

class ChambersListState extends State<ChambersList> {
  List<ChambersRepoModel> chambersList;

  ChambersListState(this.chambersList);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        body: chambersListItems() // ListView.builder() shall be used here.
        );
  }

  ListView chambersListItems() {
    return new ListView.separated(
      itemCount: chambersList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          child: singleRowContainer(context, index),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingScreen(chambersList[index].name)),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 2,
        );
      },
    );
  }

  Container singleRowContainer(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 - 6,
      child: Center(child: Text(chambersList[index].name)),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/uk-logo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
