import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';

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
              SizedBox(width: 8), // Adiciona um espaçamento entre os botões
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

  void confirmDelete({required String docID}) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Impede o fechamento ao tocar fora da caixa de diálogo
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            "Confirma a exclusão?",
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      firestoreService.deleteAmbiente(docID);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: MinhasCores.amarelo,
                    ),
                    child: Text("Confirmar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                    onPressed: () => openboxAmbiente(
                                        docID: docID,
                                        ambienteText: ambienteText),
                                    icon: const Icon(Icons.settings),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        confirmDelete(docID: docID),
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
