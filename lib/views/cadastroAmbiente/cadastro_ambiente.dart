import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';
import 'package:project_vofaze/views/cadastroAmbiente/ambiente_dialog.dart';
import 'package:project_vofaze/views/cadastroAmbiente/ambiente_item.dart';
import 'package:project_vofaze/views/cadastroAmbiente/confirm_delete_ambiente.dart';

class CadastroAmbiente extends StatefulWidget {
  const CadastroAmbiente({super.key});

  @override
  State<CadastroAmbiente> createState() => _CadastroAmbienteState();
}

class _CadastroAmbienteState extends State<CadastroAmbiente> {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Ambientes"),
            FloatingActionButton(
              mini: true, 
              backgroundColor: Colors.black,
              foregroundColor: MinhasCores.amarelo,
              onPressed: openboxAmbiente,
              child: const Icon(Icons.add),
            ),
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
                  return const Center(
                    child: Text(
                      "Sem ambiente...",
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

  void openboxAmbiente({String? docID, String? ambienteText}) {
    textController.text = ambienteText ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AmbienteDialog(
        textController: textController,
        onSave: (docID == null)
            ? () => firestoreService.addAmbiente(textController.text)
            : () => firestoreService.updateAmbiente(docID, textController.text),
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
}
