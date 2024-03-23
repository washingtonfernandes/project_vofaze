import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';
import 'package:project_vofaze/views/cadastroAmbiente/ambiente_item.dart';
import 'package:project_vofaze/views/cadastroAmbiente/confirm_delete_ambiente.dart';
import 'package:project_vofaze/views/cadastroUsuario/confirm_delete_user.dart';

class CadastroAmbiente extends StatefulWidget {
  const CadastroAmbiente({Key? key}) : super(key: key);

  @override
  State<CadastroAmbiente> createState() => _CadastroAmbienteState();
}

class _CadastroAmbienteState extends State<CadastroAmbiente> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openboxAmbiente({String? docID, String? ambienteText}) {
    textController.text = ambienteText ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: Text("Cancelar"),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (docID == null) {
                      firestoreService.addAmbiente(textController.text);
                    } else {
                      firestoreService.updateAmbiente(
                          docID, textController.text);
                    }
                    textController.clear();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: MinhasCores.amarelo,
                  ),
                  child: Text("Salvar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void confirmDelete({required String docID, required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDeleteDialogAmbiente(
        onDelete: () {
          firestoreService.deleteAmbiente(docID);
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
        title: Text("Ambientes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: MinhasCores.amarelo,
        onPressed: openboxAmbiente,
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
              stream: firestoreService.getAmbientesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List ambientesList = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: ambientesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = ambientesList[index];
                      String docID = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String ambienteText = data["ambiente"];
                      return AmbienteItem(
                        ambienteText: ambienteText,
                        onEdit: () => openboxAmbiente(
                            docID: docID, ambienteText: ambienteText),
                        onDelete: () =>
                            confirmDelete(docID: docID, context: context),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      child: const Text(
                        "Sem ambiente...",
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
