import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/model/ticket_model.dart';

class TicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TicketModel> _tickets = [];
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
    _subscription = _firestore.collection("ticket").snapshots().listen((event) {
      _tickets.clear();
      _tickets.addAll(event.docs.map((doc) => TicketModel.fromSnapshot(doc)));
      _tickets.sort(
          (a, b) => a.data.compareTo(b.data)); // Ordena os tickets por data
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTicket(TicketModel ticket) async {
    try {
      await _firestore.collection("ticket").add(ticket.toMap());
      notifyListeners();
    } catch (error) {
      print("Erro ao adicionar ticket: $error");
    }
  }

  void updateTicketStatus(TicketModel ticket, bool newStatus) {
    try {
      final docID = ticket.docID;
      if (docID != null) {
        _firestore.collection("ticket").doc(docID).update({'isDone': newStatus});
      }
    } catch (error) {
      print("Erro ao atualizar o status do ticket: $error");
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
