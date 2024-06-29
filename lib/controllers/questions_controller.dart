import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/services/questions_firebase_services.dart';

class QuestionsController extends ChangeNotifier {
  final _questionsFirebaseServices = QuestionsFirebaseServices();

  Stream<QuerySnapshot> get list {
    return _questionsFirebaseServices.getQuestions();
  }

  int _correctAnswersCount = 0;

  void addCorrectAnswer() {
    _correctAnswersCount++;
  }
}
