import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/models/question.dart';
import 'package:mood_tracker/views/widgets/manage_quiz_item.dart';
import 'package:provider/provider.dart';

class ManageQuizScreen extends StatelessWidget {
  const ManageQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsController = context.watch<QuestionsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Quiz"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton(
              onPressed: () {},
              child: const Text("Save"),
            ),
          ),
        ],
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
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = Question.fromJson(questions[index]);

                    return ManageQuizItem(
                      question: question.question,
                      variants: question.variants,
                      order: index,
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text("Add new question"),
        ),
      ),
    );
  }
}
