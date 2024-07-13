import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';
import 'package:project_vofaze/views/registerAmbient/ambient_dialog.dart';
import 'package:project_vofaze/views/registerAmbient/ambient_item.dart';
import 'package:project_vofaze/views/registerAmbient/confirm_delete_ambient.dart';

class RegisterAmbient extends StatefulWidget {
  const RegisterAmbient({super.key});

  @override
  State<RegisterAmbient> createState() => _RegisterAmbientState();
}

class _RegisterAmbientState extends State<RegisterAmbient> {
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
                      String ambientText = data["ambiente"];
                      return AmbientItem(
                        ambientText: ambientText,
                        onEdit: () => openboxAmbiente(
                            docID: docID, ambientText: ambientText),
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

  void openboxAmbiente({String? docID, String? ambientText}) {
    textController.text = ambientText ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AmbientDialog(
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
      builder: (context) => ConfirmDeleteDialogAmbient(
        onDelete: () {
          firestoreService.deleteAmbiente(docID);
          Navigator.pop(context);
        },
      ),
    );
  }
}
