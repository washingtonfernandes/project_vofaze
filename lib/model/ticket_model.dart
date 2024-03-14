import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  String? docID;
  final String titulo;
  final String descricao;
  final String setor;
  final String data;
  final String horario;

  TicketModel({
    this.docID,
    required this.titulo,
    required this.descricao,
    required this.setor,
    required this.data,
    required this.horario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descricao': descricao,
      'setor': setor,
      'data': data,
      'horario': horario,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      docID: map['docID'] != null ? map["docID"] as String : null,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      setor: map['setor'] as String,
      data: map['data'] as String,
      horario: map['horario'] as String,
    );
  }

  factory TicketModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TicketModel(
      docID: doc.id,
      titulo: doc["titulo"],
      descricao: doc["descricao"],
      setor: doc["setor"],
      data: doc["data"],
      horario: doc["horario"],
    );
  }
}

