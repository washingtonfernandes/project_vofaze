import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/ticket_service.dart';

class TicketProvider with ChangeNotifier {
  final TicketService _ticketService = TicketService();
  List<TicketModel> _tickets = [];

  TicketProvider() {
    _fetchTickets();
  }

  List<TicketModel> get tickets => _tickets;

  Future<void> _fetchTickets() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("ticket").get();
      _tickets =
          snapshot.docs.map((doc) => TicketModel.fromSnapshot(doc)).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching tickets: $error");
    }
  }
}
