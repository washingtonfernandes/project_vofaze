import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/vofaze.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final AutenticacaoServico _authService = AutenticacaoServico();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = await _authService.getCurrentUser();

    if (user != null) {
      _nomeController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Perfil'),
        backgroundColor: MinhasCores.amarelo,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundoa_app.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/images/vofaze3.png"),
                ),
                Gap(24),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome não pode ser vazio!';
                    }
                    if (value.length < 5) {
                      return 'O nome é curto!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O email não pode ser vazio!';
                    }
                    if (!value.contains('@')) {
                      return 'Email inválido!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Nova Senha',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A senha não pode ser vazia!';
                    }
                    if (value.length <= 5) {
                      return 'A senha é curta!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showUpdateConfirmationDialog(); // Mostrar diálogo de confirmação de alteração
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: MinhasCores.amarelo,
                  ),
                  child: Text(
                    'Alterar',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(); // Mostrar diálogo de confirmação de exclusão
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MinhasCores.amarelo,
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Excluir Conta',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _atualizarPerfil() async {
    if (_formKey.currentState!.validate()) {
      String nome = _nomeController.text.trim();
      String email = _emailController.text.trim();
      String senha = _senhaController.text.trim();

      String? result = await _authService.atualizarPerfil(
        novoNome: nome,
        novoEmail: email,
        novaSenha: senha,
      );

      if (result == null) {
        _showSnackbar("Perfil atualizado com sucesso!", isErro: false);
      } else {
        _showSnackbar(result);
      }
    }
  }

  void _excluirConta() async {
    String? result = await _authService.excluirConta();

    if (result == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Vofaze()),
        (route) => false,
      );
    } else {
      _showSnackbar(result);
    }
  }

  void _showSnackbar(String texto, {bool isErro = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: isErro ? Colors.red : Colors.green,
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("Confirmar Exclusão"),
          ),
          content: Text(
              "Tem certeza de que deseja excluir sua conta? Esta ação é irreversível."),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Fechar o diálogo ao clicar em "Cancelar"
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Cancelar"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o diálogo de confirmação
                    _excluirConta(); // Excluir conta após confirmação
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MinhasCores.amarelo,
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Excluir"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showUpdateConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Confirmar Alteração")),
          content: Text("Tem certeza de que deseja salvar as alterações?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Fechar o diálogo ao clicar em "Cancelar"
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                  ),
                  child: Text("Cancelar"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o diálogo de confirmação
                    _atualizarPerfil(); // Atualizar perfil após confirmação
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: MinhasCores.amarelo,
                  ),
                  child: Text("Salvar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
