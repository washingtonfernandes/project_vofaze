import 'package:flutter/material.dart';


class RadioProvider extends ChangeNotifier {

  int _selectedRadio = 0;


  int getSelectedRadio() => _selectedRadio;

  void setSelectedRadio(int value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedRadio = value;
      notifyListeners();
    });
  }

}

