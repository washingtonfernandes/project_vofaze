import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/model/message_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Serviço de mensagens
  Future<void> sendMessage(String receiverId, String message) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('Usuário não autenticado.');
      }

      final currentUserId = currentUser.uid;
      final currentUserEmail = currentUser.email ?? '';

      final Timestamp timestamp = Timestamp.now();

      Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message,
      );

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());

      notifyListeners();
    } catch (e) {
      print('Erro ao enviar mensagem: $e');
      
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    try {
      List<String> ids = [userId, otherUserId];
      ids.sort();
      String chatRoomId = ids.join("_");

      return _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      print('Erro ao obter mensagens: $e');
     
      return Stream.empty();
    }
  }
}
