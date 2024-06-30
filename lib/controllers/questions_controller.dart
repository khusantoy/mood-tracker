import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/services/questions_firebase_services.dart';

class QuestionsController extends ChangeNotifier {
  final _questionsFirebaseServices = QuestionsFirebaseServices();
  int _correctAnswersCount = 0;

  int get getCorrectAnswerCount => _correctAnswersCount;

  Stream<QuerySnapshot> get list {
    return _questionsFirebaseServices.getQuestions();
  }

  void addCorrectAnswer() {
    _correctAnswersCount++;
  }

  void resetScore() {
    _correctAnswersCount = 0;
  }
}
