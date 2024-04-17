import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class AlertDialogTicket extends StatelessWidget {
  const AlertDialogTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MinhasCores.amarelo,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "ERRO",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
      content: const Text(
        "Por favor, preencha todos os campos.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: const Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
