import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/views/drawer/drawer_home.dart';
import 'package:project_vofaze/widget/card_mylist/card_mylist_widget.dart';
import 'package:project_vofaze/widget/radio_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _searchText;

  @override
  void initState() {
    super.initState();
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: const DrawerHome(),
      appBar: AppBar(
        backgroundColor: MinhasCores.amareloBaixo,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: MinhasCores.amarelo,
            radius: 20,
            child: Image.asset('assets/images/vofaze3.png'),
          ),
          title: const Text(
            "Olá, bem-vindo",
            style: TextStyle(fontSize: 12),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user != null
                    ? user.displayName ?? "Nome do Usuário"
                    : "Nome do Usuário",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                user != null ? user.email ?? "Email" : "Email",
                style: const TextStyle(fontSize: 6),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.exit_to_app_sharp),
            onPressed: () {
              AutenticacaoServico().deslogar();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/fundo_app.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Meus tickets",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Manut"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Limp"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Admin"),
                    ),
                  ],
                ),
              ]),
              Expanded(
                child: Consumer<TicketProvider>(
                  builder: (context, ticketProvider, _) {
                    final tickets = ticketProvider.tickets.where((ticket) {
                      final lowerCaseSearchText = _searchText.toLowerCase();

                      return ticket.titulo
                              .toLowerCase()
                              .contains(lowerCaseSearchText) ||
                          ticket.descricao
                              .toLowerCase()
                              .contains(lowerCaseSearchText) ||
                          ticket.horario
                              .toLowerCase()
                              .contains(lowerCaseSearchText) ||
                          ticket.data
                              .toLowerCase()
                              .contains(lowerCaseSearchText);
                    }).toList();

                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) => CardMyListWidget(
                        getIndex: index,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
