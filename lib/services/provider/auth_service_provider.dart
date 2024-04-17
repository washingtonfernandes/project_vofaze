import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class AutenticacaoServico with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _usuario;

  User? get usuario => _usuario;

  bool isLoading = true;

  AutenticacaoServico() {
    _firebaseAuth.authStateChanges().listen((user) {
      _usuario = user;

      isLoading = false;

      notifyListeners();
    });
  }

  Future<String?> addUserAuth({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      // Criação do usuário no Firebase Auth
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualização do nome do usuário no Firebase Auth
      await userCredential.user!.updateDisplayName(nome);

      // Obtém o ID do usuário gerado pelo Firebase Auth
      String userId = userCredential.user!.uid;

      // Criação do documento na coleção "users" no Firestore
      await _firestore.collection('users').doc(userId).set({
        'userId': userId, // Adiciona o ID do usuário como campo no Firestore
        'nome': nome,
        'email': email,
      });

      return null; // Sucesso
    } catch (e) {
      print("Erro ao criar usuário e documento no Firestore: $e");
      return "Erro ao criar usuário.";
    }
  }

  Future<String?> logarUsuarios(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return "Verifique seu email ou sua senha!";
      }

      return "Usuário não cadastrado ou senha incorreta!";
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }

  //----------------------------------------
  Future<String?> updateUserProfile({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      if (_usuario != null) {
        // Atualiza o nome do usuário no Firebase Auth
        await _usuario!.updateDisplayName(nome);

        // Atualiza o email do usuário no Firebase Auth (se diferente)
        if (_usuario!.email != email) {
          await _usuario!.updateEmail(email);
        }

        // Atualiza a senha do usuário no Firebase Auth (se diferente)
        await _usuario!.updatePassword(senha);

        // Atualiza os dados no Firestore
        await _firestore.collection('users').doc(_usuario!.uid).update({
          'nome': nome,
          'email': email,
        });

        return null; // Sucesso
      } else {
        return "Usuário não autenticado.";
      }
    } catch (e) {
      print("Erro ao atualizar perfil: $e");
      return "Erro ao atualizar perfil.";
    }
  }

  Future<String?> deleteAccount() async {
    try {
      if (_usuario != null) {
        // Exclui o usuário do Firebase Auth
        await _usuario!.delete();

        // Exclui os dados do usuário do Firestore
        await _firestore.collection('users').doc(_usuario!.uid).delete();

        return null; // Sucesso
      } else {
        return "Usuário não autenticado.";
      }
    } catch (e) {
      print("Erro ao excluir conta: $e");
      return "Erro ao excluir conta.";
    }
  }
}
