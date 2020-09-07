import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testApp/view/age_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = Firestore.instance;

  @override
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
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final names = snapshot.data.documents;
              List<ListTile> namesWidgets = [];
              for (var name in names) {
                final missionName = name.data['name'];
                final id = name.documentID;
                final nameWidget = ListTile(
                  title: Text('$missionName'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AgePage(
                            documentId: id,
                          );
                        },
                      ),
                    );
                  },
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
