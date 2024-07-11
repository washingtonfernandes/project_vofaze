import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/vofaze.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final AutenticacaoServico _authService = AutenticacaoServico();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _authService.getCurrentUser();

      if (user != null) {
        setState(() {
          _nomeController.text = user.displayName ?? '';
          _emailController.text = user.email ?? '';
        });
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Perfil'),
        backgroundColor: MinhasCores.amarelo,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/images/vofaze3.png"),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Digite sua senha ou uma nova senha!',
                    labelStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showUpdateConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: MinhasCores.amarelo,
                  ),
                  child: const Text(
                    'Alterar',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MinhasCores.amarelo,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
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

  Future<void> _atualizarPerfil() async {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text.trim();
      final email = _emailController.text.trim();
      final senha = _senhaController.text.trim();

      try {
        final result = await _authService.atualizarPerfil(
          novoNome: nome,
          novoEmail: email,
          novaSenha: senha,
        );

        if (result == null) {
          _showSnackbar("Perfil atualizado com sucesso!", isErro: false);
        } else {
          _showSnackbar(result);
        }
      } catch (e) {
        print('Erro ao atualizar perfil: $e');
        _showSnackbar('Erro ao atualizar perfil. Por favor, tente novamente.');
      }
    }
  }

  Future<void> _excluirConta() async {
    try {
      final result = await _authService.excluirConta();

      if (result == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Vofaze()),
          (route) => false,
        );
      } else {
        _showSnackbar(result);
      }
    } catch (e) {
      print('Erro ao excluir conta: $e');
      _showSnackbar('Erro ao excluir conta. Por favor, tente novamente.');
    }
  }

  void _showSnackbar(String texto, {bool isErro = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: isErro ? Colors.red : Colors.green,
        duration: const Duration(seconds: 5),
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
          title: const Center(
            child: Text("Confirmar Exclusão"),
          ),
          content: const Text(
              "Tem certeza de que deseja excluir sua conta? Esta ação é irreversível."),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Cancelar"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _excluirConta();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MinhasCores.amarelo,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Excluir"),
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
          title: const Center(child: Text("Confirmar Alteração")),
          content:
              const Text("Tem certeza de que deseja salvar as alterações?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Cancelar"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _atualizarPerfil();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: MinhasCores.amarelo,
                  ),
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
