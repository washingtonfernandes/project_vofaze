import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_vofaze/model/ticket_model.dart';

class TicketServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTicket(TicketModel ticket) async {
    try {
      await _firestore.collection("ticket").add(ticket.toMap());
      // Apenas adiciona ao Firebase, não atualiza localmente aqui
    } catch (error) {
      print("Erro ao adicionar ticket: $error");
    }
  }
}
