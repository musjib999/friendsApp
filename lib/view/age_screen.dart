import 'package:flutter/material.dart';
import 'package:testApp/services/database_service.dart';

class AgePage extends StatelessWidget {
  final documentId;
  AgePage({this.documentId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getAgeById(documentId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('${snapshot.data['name']}'),
            ),
            body: Center(
              child: Text(
                  '${snapshot.data['name']} age is :${snapshot.data['age']}'),
            ),
          );
        });
  }
}
