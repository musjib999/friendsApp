import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    missionsStream();
  }

  final _firestore = Firestore.instance;

  // void getCourseTitle() async {
  //   final names = await _firestore.collection('missions').getDocuments();
  //   for (var name in names.documents) {
  //     print(name.data);
  //   }
  // }

  void missionsStream() async {
    await for (var snapshot in _firestore.collection('missions').snapshots()) {
      for (var name in snapshot.documents) {
        print(name.data['name']);
      }
    }
  }

  // void getMissions() async{
  //   final missions = await  _firestore.collection('missions').document();
  //   print(missions);
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Friends App'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          StreamBuilder(
            stream: _firestore.collection('missions').snapshots(),
            builder: (context, snapshot) {
              final names = snapshot.data.documents;
              List<ListTile> namesWidgets = [];
              for (var name in names) {
                final missionName = name.data['name'];
                final age = name.data['age'];
                final nameWidget = ListTile(
                  title: Text('$missionName'),
                    subtitle: Text('$age'),
                  );
                namesWidgets.add(nameWidget);
              }
              return Column(
                children: namesWidgets,
              );
            },
          ),
        ],
      ),
    );
  }
}
