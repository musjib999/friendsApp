import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _firestore = Firestore.instance;

  Future getAgeById(id) async {
    final result = await _firestore.collection('missions').document(id).get();
    var age = result.data;
    return age;
  }
}
