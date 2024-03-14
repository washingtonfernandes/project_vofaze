import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }
}
