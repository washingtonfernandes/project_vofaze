import 'package:flutter/material.dart';

class AmbienteItem extends StatelessWidget {
  final String ambienteText;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AmbienteItem({
    Key? key,
    required this.ambienteText,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              ambienteText,
              style: TextStyle(fontSize: 18),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
