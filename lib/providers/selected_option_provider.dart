import 'package:flutter/material.dart';

class SelectedOptionProvider with ChangeNotifier {
  int _selectedOption = -1;

  int get selectedOption => _selectedOption;

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners();
  }
}
