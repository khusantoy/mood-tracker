import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:provider/provider.dart';

class QuizItem extends StatefulWidget {
  final int orderNumber = 0;
  final String question;
  final List variants;
  final int correctAnswerID;
  final VoidCallback? nextPage;
  final int currentIndex;
  final int contentLength;

  const QuizItem({
    super.key,
    required orderNumber,
    required this.question,
    required this.correctAnswerID,
    required this.variants,
    required this.contentLength,
    required this.currentIndex,
    this.nextPage,
  });

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  int _selectedValue = -1;

  String _getLabel(int index) {
    return '${String.fromCharCode(65 + index)})';
  }

  bool isQuizCompleted = false;
  bool _showWidget = true;

  void _removeWidgetAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showWidget = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<QuestionsController>(
        builder: (context, questionManage, child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: isQuizCompleted == true
              ? Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Your Score: ${questionManage.getCorrectAnswerCount}",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Back to home page"),
                            )
                          ],
                        ),
                      ),
                      if (_showWidget)
                        Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            "assets/anim.json",
                            repeat: false,
                          ),
                        )
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "${widget.currentIndex + 1}. ${widget.question}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var i = 0; i < widget.variants.length; i++)
                      ListTile(
                        title: Text(widget.variants[i]),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<int>(
                              value: i,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value!;
                                  widget.nextPage!();
                                  if (widget.correctAnswerID == value) {
                                    questionManage.addCorrectAnswer();
                                    _removeWidgetAfterDelay();
                                  }
                                  if (widget.currentIndex ==
                                      widget.contentLength) {
                                    isQuizCompleted = true;
                                  }
                                });
                              },
                            ),
                            Text(
                              _getLabel(i),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
    ;
  }
}
