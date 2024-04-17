import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime? _selectedDate;

  TimeOfDay? _selectedTime;

  DateTime? get selectedDate => _selectedDate;

  TimeOfDay? get selectedTime => _selectedTime;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;

    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;

    notifyListeners();
  }
}
