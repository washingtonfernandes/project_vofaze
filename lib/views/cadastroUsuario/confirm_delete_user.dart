import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class ConfirmDeleteDialogUser extends StatelessWidget {
  final VoidCallback onDelete;

  const ConfirmDeleteDialogUser({required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
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
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          TextButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: MinhasCores.amarelo,
            ),
            child: Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}
