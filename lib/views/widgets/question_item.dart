import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/providers/selected_option_provider.dart';
import 'package:provider/provider.dart';

class QuestionItem extends StatefulWidget {
  final String title;
  final int radioValue;

  const QuestionItem(
      {super.key, required this.title, required this.radioValue});

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  @override
  Widget build(BuildContext context) {
    final selectedOptionProvider = context.watch<SelectedOptionProvider>();
    // final questionsController = context.watch<QuestionsController>();

    return ListTile(
      title: Text(widget.title),
      leading: Radio<int>(
        value: widget.radioValue,
        groupValue: selectedOptionProvider.selectedOption,
        onChanged: (int? value) {
          selectedOptionProvider.setSelectedOption(value!);
          // _pageController.nextPage(
          //     duration: const Duration(seconds: 1), curve: Curves.linear);
        },
      ),
    );
  }
}
