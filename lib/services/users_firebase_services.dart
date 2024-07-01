import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFirebaseServices {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  void addUser({required String username}) async {
    await _userCollection.add({"username": username});
  }
}
