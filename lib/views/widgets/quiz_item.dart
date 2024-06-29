import 'package:flutter/material.dart';

class QuizItem extends StatefulWidget {
  final int orderNumber = 0;
  final String question;
  final List variants;
  final VoidCallback? nextPage;
  const QuizItem({
    super.key,
    required orderNumber,
    required this.question,
    required this.variants,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "${widget.orderNumber}. ${widget.question}",
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
    );
    ;
  }
}
