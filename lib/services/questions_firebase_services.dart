import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsFirebaseServices {
  final _questionCollection =
      FirebaseFirestore.instance.collection("questions");

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _questionCollection.snapshots();
  }
}
