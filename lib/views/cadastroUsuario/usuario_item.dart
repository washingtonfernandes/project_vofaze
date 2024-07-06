import 'package:flutter/material.dart';

class UsuarioItem extends StatelessWidget {
  final String usuarioText;
  final String emailText;
  final VoidCallback? onDelete;
  final bool isDeletable;

  const UsuarioItem({
    super.key,
    required this.usuarioText,
    required this.emailText,
    this.onDelete,
    this.isDeletable = true, 
  });

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
              usuarioText,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              emailText,
              style: const TextStyle(fontSize: 10),
            ),
            trailing: isDeletable
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onDelete != null)
                        IconButton(
                          onPressed: onDelete!,
                          icon: const Icon(Icons.delete),
                        ),
                    ],
                  )
                : null, 
          ),
        ),
      ),
    );
  }
}
