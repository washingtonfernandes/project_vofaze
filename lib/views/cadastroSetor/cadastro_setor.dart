import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/firestore_services.dart';

class CadastroSetor extends StatefulWidget {
  const CadastroSetor({Key? key}) : super(key: key);

  @override
  State<CadastroSetor> createState() => _CadastroSetorState();
}

class _CadastroSetorState extends State<CadastroSetor> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openboxSetor({String? docID, String? setorText}) {
    textController.text = setorText ?? '';

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
                      firestoreService.addSetor(textController.text);
                    } else {
                      firestoreService.updateSetor(docID, textController.text);
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
                      firestoreService.deleteSetor(docID);
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
        title: Text("Setores"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: MinhasCores.amarelo,
        onPressed: openboxSetor,
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
              stream: firestoreService.getSetoresStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List setoresList = snapshot.data!.docs;
                  //retorno da lista
                  return ListView.builder(
                    itemCount: setoresList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = setoresList[index];
                      String docID = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String setorText = data["setor"];
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            //o ListTile vai preencher a lista
                            child: ListTile(
                              title: Text(
                                setorText,
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //botãopara editar
                                  IconButton(
                                    onPressed: () => openboxSetor(
                                        docID: docID, setorText: setorText),
                                    icon: const Icon(Icons.settings),
                                  ),

                                  //botão para deletar
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
                    "Sem setor...",
                    style: TextStyle(fontSize: 16),
                  )));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
