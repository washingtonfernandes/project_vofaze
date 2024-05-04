import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class ConfirmDeleteDialogAmbiente extends StatelessWidget {
  final VoidCallback onDelete;

  const ConfirmDeleteDialogAmbiente({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Confirma a exclusão?",
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Flexible(
            child: TextButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: MinhasCores.amarelo,
              ),
              child: const Text("Confirmar"),
            ),
          ),
        ],
      ),
    );
  }
}