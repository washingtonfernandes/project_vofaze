import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class UserDialog extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSave;

  const UserDialog({
    super.key,
    required this.textController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          child: const Text("Cancelar"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            String userInput = textController.text;
            String capitalizedText = capitalize(userInput);
            textController.text = capitalizedText;
            onSave();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: MinhasCores.amarelo,
          ),
          child: const Text("Salvar"),
        ),
      ],
    );
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
