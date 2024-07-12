import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/common/snackbar_login.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/recoverPassword/recuperar_senha.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _codigoAcessoController = TextEditingController();

  final AutenticacaoServico _autenticaServico = AutenticacaoServico();

  bool _obscureText = true;

  InputDecoration getAuthenticationInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: MinhasCores.amareloBaixo,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo_app.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "assets/images/vofaze3.png",
                          height: 120,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: getAuthenticationInputDecoration("Email"),
                          cursorColor: Colors.black,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "O email não pode ser vazio!";
                            }

                            if (value.length < 5 || !value.contains("@")) {
                              return "Email não válido!";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          controller: _senhaController,
                          decoration: getAuthenticationInputDecoration("Senha")
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "A senha não pode ser vazia!";
                            }

                            if (value.length <= 5) {
                              return "A senha é curta!";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Visibility(
                          visible: !queroEntrar,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: _nomeController,
                                decoration:
                                    getAuthenticationInputDecoration("Nome"),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "O nome não pode ser vazio!";
                                  }

                                  if (value.length < 5) {
                                    return "O nome é curto!";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              TextFormField(
                                controller: _codigoAcessoController,
                                decoration: getAuthenticationInputDecoration(
                                    "Código de Acesso"),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "O código de acesso não pode ser vazio!";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: botaoPrincipalClicado,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            queroEntrar ? "Entrar" : "Cadastrar",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 8,
                          color: Colors.black,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              queroEntrar = !queroEntrar;
                            });
                          },
                          child: Text(
                            queroEntrar
                                ? "Ainda não é cadastrado? Cadastre-se!"
                                : "Já tem uma conta? Entre!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RecuperarSenha();
                            }));
                          },
                          child: const Text(
                            "Esqueci a senha",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;
    String codigoAcesso = _codigoAcessoController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        _autenticaServico
            .logarUsuarios(email: email, senha: senha)
            .then((String? erro) {
          if (erro != null) {
            showSnackbar(context: context, texto: erro);
          }
        });
      } else {
        _autenticaServico
            .addUserAuth(
          nome: nome,
          senha: senha,
          email: email,
          codigoAcesso: codigoAcesso,
        )
            .then(
          (String? erro) {
            if (erro != null) {
              showSnackbar(context: context, texto: erro);
            }
          },
        );
      }
    } else {
      print("Form inválido");
    }
  }
}
