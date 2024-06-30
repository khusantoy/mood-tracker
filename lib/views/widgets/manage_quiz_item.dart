import 'package:flutter/material.dart';

class ManageQuizItem extends StatefulWidget {
  final String question;
  final List variants;
  final int order;
  const ManageQuizItem({
    super.key,
    required this.question,
    required this.variants,
    required this.order,
  });

  @override
  State<ManageQuizItem> createState() => _ManageQuizItemState();
}

class _ManageQuizItemState extends State<ManageQuizItem> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<TextEditingController> _textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String _getLabel(int index) {
    return '${String.fromCharCode(65 + index)})';
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.question;

    for (var i = 0; i < 4; i++) {
      _textEditingControllers[i].text = widget.variants[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                label: Text("Question ${widget.order + 1}"),
              ),
              controller: _textEditingController,
            ),
          ),
          for (var i = 0; i < widget.variants.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  icon: Text(
                    _getLabel(i),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller: _textEditingControllers[i],
              ),
            ),
        ],
      ),
    );
  }
}
