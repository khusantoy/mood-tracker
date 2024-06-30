import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/models/question.dart';
import 'package:mood_tracker/views/widgets/quiz_item.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();
  int orderNumber = 0;

  @override
  Widget build(BuildContext context) {
    final questionsController = context.watch<QuestionsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
      ),
      body: StreamBuilder(
        stream: questionsController.list,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("No available questions"),
            );
          }
          final questions = snapshot.data!.docs;

          return questions.isEmpty
              ? const Center(
                  child: Text("No available questions"),
                )
              : PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = Question.fromJson(questions[index]);
                    orderNumber++;
                    return QuizItem(
                        orderNumber: orderNumber,
                        question: question.question,
                        correctAnswerID: question.correctAnswerID,
                        variants: question.variants,
                        currentIndex: index,
                        contentLength: questions.length - 1,
                        nextPage: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          });
                        });
                  },
                );
        },
      ),
    );
  }
}
