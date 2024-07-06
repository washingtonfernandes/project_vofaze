import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 182, 146, 0), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 182, 146, 0), width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 255, 166, 0), width: 3),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 255, 166, 0), width: 4),
    ),
  );
}
