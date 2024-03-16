import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/ticket_service.dart';

class TicketProvider with ChangeNotifier {
  final TicketServiceProvider _ticketServiceProvider = TicketServiceProvider();
  List<TicketModel> _tickets = [];
  bool _isLoading = true;
  String? _error;

  TicketProvider() {
    _fetchTickets();
  }

  List<TicketModel> get tickets => _tickets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _fetchTickets() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("ticket").get();
      _tickets =
          snapshot.docs.map((doc) => TicketModel.fromSnapshot(doc)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _error = "Erro ao buscar tickets: $error";
      _isLoading = false;
      print(_error);
      notifyListeners();
    }
  }
}
