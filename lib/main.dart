import 'package:flutter/material.dart';
import 'package:uk_chambers/blocs/chambers_repo_bloc.dart';
import 'package:uk_chambers/remote/repository.dart';
import 'package:provider/provider.dart';

import 'booking_screen.dart';

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
          child: ChambersList(),
        ),
      ),
    );
  }
}

class ChambersList extends StatefulWidget {
  @override
  ChambersListState createState() => ChambersListState();
}

class ChambersListState extends State<ChambersList> {
  List<String> chambersList = ["First", "Second", "Third"];

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
                  builder: (context) => BookingScreen(chambersList[index])),
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
      child: Center(child: Text(chambersList[index])),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/uk-logo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
