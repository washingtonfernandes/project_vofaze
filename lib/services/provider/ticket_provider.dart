import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/model/ticket_model.dart';

class TicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<TicketModel> _tickets = [];
  bool _isLoading = true;
  String? _error;
  late StreamSubscription<QuerySnapshot> _subscription;

  TicketProvider() {
    _subscribeToTickets();
  }

  List<TicketModel> get tickets => _tickets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _subscribeToTickets() {
    _subscription =
        _firestore.collection("tickets").snapshots().listen((event) {
      _tickets.clear();
      _tickets.addAll(event.docs.map((doc) => TicketModel.fromSnapshot(doc)));
      _tickets.sort((a, b) => a.data.compareTo(b.data));
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTicket(TicketModel ticket) async {
    try {
      await _firestore.collection("tickets").add(ticket.toMap());
      notifyListeners();
    } catch (error) {
      print("Erro ao adicionar ticket: $error");
    }
  }

  Future<void> updateTicketStatus(TicketModel ticket, bool newStatus) async {
    try {
      final docID = ticket.docID;
      if (docID != null) {
        _firestore
            .collection("tickets")
            .doc(docID)
            .update({'isDone': newStatus});
      }
    } catch (error) {
      print("Erro ao atualizar o status do ticket: $error");
    }
  }

  Future<void> deleteTicket(String? docId) async {
    try {
      await _firestore.collection("tickets").doc(docId).delete();
      notifyListeners();
    } catch (error) {
      print("Erro ao deletar ticket: $error");
    }
  }

  Future<void> updateTicket(TicketModel ticket) async {
    try {
      final docID = ticket.docID;
      if (docID != null) {
        _firestore.collection("tickets").doc(docID).update(ticket.toMap());
        notifyListeners();
      }
    } catch (error) {
      print("Erro ao atualizar o ticket: $error");
    }
  }

  Future<void> confirmDelete(String? docID, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            "Confirma a exclusão?",
            style: TextStyle(
              color: Colors.black,
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
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      await deleteTicket(docID);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: MinhasCores.amarelo,
                    ),
                    child: const Text("Confirmar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmUpdate(TicketModel ticket, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            "Confirma a atualização?",
            style: TextStyle(
              color: Colors.black,
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
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      await updateTicket(ticket);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: MinhasCores.amarelo,
                    ),
                    child: const Text("Confirmar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveTicket(TicketModel ticket) async {
    if (ticket.docID != null) {
      updateTicket(ticket);
    } else {
      addTicket(ticket);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
