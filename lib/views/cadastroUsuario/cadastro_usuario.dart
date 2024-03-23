import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';
import 'package:project_vofaze/views/cadastroUsuario/confirm_delete_user.dart';
import 'package:project_vofaze/views/cadastroUsuario/usuario_dialog.dart';
import 'package:project_vofaze/views/cadastroUsuario/usuario_item.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openboxUsuario({String? docID, String? usuarioText}) {
    textController.text = usuarioText ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UsuarioDialog(
        textController: textController,
        onSave: (docID == null)
            ? () => firestoreService.addUser(textController.text)
            : () => firestoreService.updateUser(docID, textController.text),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MinhasCores.amarelo,
        elevation: 0,
        centerTitle: true,
        title: Text("Usuários"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: MinhasCores.amarelo,
        onPressed: openboxUsuario,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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

                      return UsuarioItem(
                        usuarioText: usuarioText,
                        onEdit: () => openboxUsuario(
                            docID: docID, usuarioText: usuarioText),
                        onDelete: () =>
                            confirmDelete(docID: docID, context: context),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      child: const Text(
                        "Sem usuário...",
                        style: TextStyle(fontSize: 16),
                      ),
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
}
