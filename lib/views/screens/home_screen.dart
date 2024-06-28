import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/models/question.dart';
import 'package:mood_tracker/providers/selected_option_provider.dart';
import 'package:mood_tracker/views/widgets/question_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isQuestionStarted = false;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final questionsController = context.watch<QuestionsController>();
    final selectedOptionProvider = context.watch<SelectedOptionProvider>();

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          firstChild: StreamBuilder(
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
                  : PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = Question.fromJson(questions[index]);
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  "${index + 1}. ${question.question}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              for (int i = 0; i < question.variants.length; i++)
                                QuestionItem(
                                  title: question.variants[i],
                                  radioValue: i,
                                )
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
          secondChild: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        isQuestionStarted = true;
                        setState(() {});
                      },
                      child: const Text("Start Quiz"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Manage quiz",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState: isQuestionStarted
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
