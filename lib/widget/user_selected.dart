import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class UserSelectionWidget extends StatelessWidget {
  final String selectedUser;
  final ValueChanged<String?>? onChanged;

  const UserSelectionWidget({super.key, 
    required this.selectedUser,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Usuários",
          style: TextStyle(fontSize: 16),
        ),
        Container(
          decoration: BoxDecoration(
            color: MinhasCores.amareloBaixo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    value: null,
                    strokeWidth: 2,
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return const Text("Erro ao carregar dados do usuário");
                } else {
                  List<DropdownMenuItem<String>> userItems = [];

                  // Adicione "Todos" como o primeiro item
                  userItems.add(
                    const DropdownMenuItem(
                      value: "Todos",
                      child: Text("Todos"),
                    ),
                  );

                  // Adicione outros usuários como itens subsequentes
                  final users = snapshot.data?.docs.reversed.toList();
                  if (users != null) {
                    for (var user in users) {
                      userItems.add(
                        DropdownMenuItem(
                          value: user.id,
                          child: Text(user['nome']),
                        ),
                      );
                    }
                  }

                  return DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black38),
                    underline: Container(
                      height: 2,
                      color: Colors.black12,
                    ),
                    items: userItems,
                    onChanged: onChanged,
                    value: userItems.any((item) => item.value == selectedUser)
                        ? selectedUser
                        : "Todos", 
                    isExpanded: false,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
