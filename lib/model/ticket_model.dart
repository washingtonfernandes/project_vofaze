import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  String? docID;
  final String titulo;
  final String descricao;
  final String setor;
  final String data;
  final String horario;
  bool isDone;
  final String userId;
  final String ambienteId;

  TicketModel({
    this.docID,
    required this.titulo,
    required this.descricao,
    required this.setor,
    required this.data,
    required this.horario,
    required this.isDone,
    required this.userId,
    required this.ambienteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descricao': descricao,
      'setor': setor,
      'data': data,
      'horario': horario,
      'isDone': isDone,
      'userId': userId,
      'ambienteId': ambienteId,
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
      isDone: map['isDone'] as bool,
      userId: map['userId'] as String,
      ambienteId: map['ambienteId'] as String,
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
      isDone: doc["isDone"],
      userId: doc["userId"],
      ambienteId: doc["ambienteId"],
    );
  }
}
