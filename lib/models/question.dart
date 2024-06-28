import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id;
  String question;
  List variants;

  Question({required this.id, required this.question, required this.variants});

  factory Question.fromJson(QueryDocumentSnapshot query) {
    return Question(
      id: query.id,
      question: query['question'],
      variants: query['variants'],
    );
  }
}
