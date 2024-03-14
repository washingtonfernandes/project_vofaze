import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/drawer/drawer_home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(),
      appBar: AppBar(
        backgroundColor: MinhasCores.amarelo,
        title: Text("Minhas tarefas"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/fundo_app.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        AutenticacaoServico().deslogar();
                      },
                      child: Icon(
                        Icons.exit_to_app,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
