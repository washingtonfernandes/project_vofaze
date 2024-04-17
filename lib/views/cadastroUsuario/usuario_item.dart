import 'package:flutter/material.dart';

class UsuarioItem extends StatelessWidget {
  final String usuarioText;
  final String emailText;
  final VoidCallback? onDelete;
  final bool isDeletable; // Adiciona o parâmetro isDeletable

  const UsuarioItem({
    Key? key,
    required this.usuarioText,
    required this.emailText,
    this.onDelete,
    this.isDeletable = true, // Define isDeletable como true por padrão
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
              usuarioText,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              emailText,
              style: TextStyle(fontSize: 10),
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
                : null, // Retorna null se isDeletable for false
          ),
        ),
      ),
    );
  }
}
