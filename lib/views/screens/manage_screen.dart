import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:provider/provider.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    final questionsController = context.watch<QuestionsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage questions"),
      ),
      body: StreamBuilder(
        stream: questionsController.list,
        builder: (context, snapshot) {
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
                  child: Text("No available question"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return null;
                  },
                );
        },
      ),
    );
  }
}
