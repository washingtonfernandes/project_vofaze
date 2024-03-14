import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/model/ticket_model.dart';

class TicketService extends ChangeNotifier {
  final ticketCollection = FirebaseFirestore.instance.collection("ticket");

  // CRUD

  // CREATE
  Future<void> addTicket(TicketModel model) async {
    await ticketCollection.add(model.toMap());
  }
}
