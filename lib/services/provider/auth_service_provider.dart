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


  Future<String?> cadastrarUsuario({

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


      // Criação do documento na coleção "users" no Firestore


      await _firestore.collection('users').doc(userCredential.user!.uid).set({

        'nome': nome,

      });


      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == "email-already-in-use") {

        return "O usuário já está cadastrado";

      }


      return "Cadastre uma senha com mais de 6 caracteres!";

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

}

