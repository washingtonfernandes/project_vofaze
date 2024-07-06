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
    required String codigoAcesso,
  }) async {
    try {
      // Verificação do código de acesso
      bool isAdmin = await _checkAdminCode(codigoAcesso);

      // Criação do usuário no Firebase Auth
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualização do nome do usuário no Firebase Auth
      await userCredential.user!.updateDisplayName(nome);

      // Criação do documento na coleção "users" no Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'nome': nome,
        'email': email,
        'isAdmin': isAdmin,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado";
      }
      return "Cadastre uma senha com mais de 6 caracteres!";
    } catch (e) {
      return "Erro no cadastro: $e";
    }
  }

  Future<bool> _checkAdminCode(String code) async {
    try {
      QuerySnapshot<Map<String, dynamic>> senhaSnapshot =
          await _firestore.collection('senhas').limit(1).get();

      if (senhaSnapshot.docs.isNotEmpty) {
        var senhaDoc = senhaSnapshot.docs.first.data();

        String userCode = senhaDoc['cod_user'];
        String adminCode = senhaDoc['cod_adm'];

        if (code == userCode) {
          return false;
        } else if (code == adminCode) {
          return true;
        }
      }
    } catch (e) {
      print('Erro ao verificar o código de acesso: $e');
    }

    throw Exception('Código de acesso inválido');
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

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<String?> atualizarPerfil({
    required String novoNome,
    required String novoEmail,
    required String novaSenha,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Atualizar nome e email no Firebase Auth
        await user.updateDisplayName(novoNome);
        await user.updateEmail(novoEmail);

        // Atualizar senha apenas se uma nova senha for fornecida
        if (novaSenha.isNotEmpty) {
          await user.updatePassword(novaSenha);
        }

        // Atualizar dados no Firestore
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).update({
          'nome': novoNome,
          'email': novoEmail,
        });

        return null; 
      } else {
        return "Usuário não encontrado.";
      }
    } catch (e) {
      print("Erro ao atualizar perfil: $e");
      return "Erro ao atualizar perfil.";
    }
  }

  Future<String?> excluirConta() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Excluir usuário do Firebase Auth
        await user.delete();

        // Excluir documento do Firestore
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).delete();

        // Deslogar o usuário
        await deslogar();

        return null;
      } else {
        return "Usuário não encontrado.";
      }
    } catch (e) {
      print("Erro ao excluir conta: $e");
      return "Erro ao excluir conta.";
    }
  }
}
