import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';
import 'package:project_vofaze/views/registerUser/confirm_delete_user.dart';
import 'package:project_vofaze/views/registerUser/user_item.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MinhasCores.amarelo,
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Usuários"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo_app.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List usuariosList = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: usuariosList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = usuariosList[index];
                      String docID = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String usuarioText = data["nome"];
                      String emailText = data["email"];

                      // Verifica se o nome do usuário é "Todos"
                      bool isTodos = usuarioText == "Todos";

                      return UserItem(
                        usuarioText: usuarioText,
                        emailText: emailText,
                        isDeletable: !isTodos,
                        onDelete: isTodos
                            ? null
                            : () =>
                                confirmDelete(docID: docID, context: context),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Sem usuário...",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void confirmDelete({required String docID, required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDeleteDialogUser(
        onDelete: () {
          firestoreService.deleteUser(docID);
          Navigator.pop(context);
        },
      ),
    );
  }
}
