import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // AMBIENTES -----------------------------------------------------------

  final CollectionReference ambientes =
      FirebaseFirestore.instance.collection("ambientes");

  // adicionar un novo ambiente

  Future<void> addAmbiente(String ambiente) {
    return ambientes.add({
      "ambiente": ambiente,
    });
  }

  // retornar os ambientes

  Stream<QuerySnapshot> getAmbientesStream() {
    final ambientesStream =
        ambientes.orderBy("ambiente", descending: true).snapshots();

    return ambientesStream;
  }

  // alterar

  Future<void> updateAmbiente(String docID, String newambiente) {
    return ambientes.doc(docID).update({
      "ambiente": newambiente,
    });
  }

  // deletar

  Future<void> deleteAmbiente(String docID) {
    return ambientes.doc(docID).delete();
  }

  // USUÁRIOS -----------------------------------------------------------

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  // adicionar un novo usuário

  Future<void> addUser(String nome) {
    return users.add({
      "nome": nome,
    });
  }

  // retornar os usuarios

  Stream<QuerySnapshot> getUsersStream() {
    final usersStream = users.orderBy("nome", descending: true).snapshots();

    return usersStream;
  }

  // alterar

  Future<void> updateUser(String docID, String newnome) {
    return users.doc(docID).update({
      "nome": newnome,
    });
  }

  // deletar

  Future<void> deleteUser(String docID) {
    return users.doc(docID).delete();
  }
}
