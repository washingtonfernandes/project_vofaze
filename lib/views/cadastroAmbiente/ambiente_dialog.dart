import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class AmbienteDialog extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSave;

  const AmbienteDialog({
    Key? key,
    required this.textController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
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
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          child: Text("Cancelar"),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: MinhasCores.amarelo,
          ),
          child: Text("Salvar"),
        ),
      ],
    );
  }
}