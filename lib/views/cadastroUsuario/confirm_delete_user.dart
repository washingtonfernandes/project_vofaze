import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class ConfirmDeleteDialogUser extends StatelessWidget {
  final VoidCallback onDelete;

  const ConfirmDeleteDialogUser({required this.onDelete, super.key});

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
          TextButton(
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
          const SizedBox(
            width: 18,
          ),
          TextButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: MinhasCores.amarelo,
            ),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}
