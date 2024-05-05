import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/chat/chat_page.dart';
import 'package:provider/provider.dart';

class ChatMsg extends StatefulWidget {
  const ChatMsg({super.key});

  @override
  State<ChatMsg> createState() => _ChatMsgState();
}

class _ChatMsgState extends State<ChatMsg> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void deslogar() {
    final authService =
        Provider.of<AutenticacaoServico>(context, listen: false);

    authService.deslogar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.amareloBaixo,
      appBar: AppBar(
        backgroundColor: MinhasCores.amarelo,
        title: Text("Mensagens"),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fundoc_app.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildUserList()),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erro ao carregar usuários');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Carregando usuários...');
        }

        // Lista atual de documentos de usuários
        List<DocumentSnapshot> documents = snapshot.data!.docs;

        // Filtra os documentos para excluir usuários excluídos
        List<DocumentSnapshot> activeUsers = documents.where((doc) {
          // Verifica se o documento tem dados válidos de usuário
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          return (data != null && data['email'] != null && data['uid'] != null);
        }).toList();

        return ListView(
          children: activeUsers.map((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data != null) {
      String? userEmail = data['email'] as String?;
      String? userId = data['uid'] as String?;

      if (_auth.currentUser != null &&
          userEmail != null &&
          userId != null &&
          _auth.currentUser!.email != userEmail) {
        String userName = userEmail.split('@').first;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: MinhasCores.amarelo,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                userName,
                style: TextStyle(color: Colors.black),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserEmail: userEmail,
                    receiverUserId: userId,
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    return Container();
  }
}
