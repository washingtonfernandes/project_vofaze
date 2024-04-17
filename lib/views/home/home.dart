import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/views/drawer/drawer_home.dart';
import 'package:project_vofaze/widget/card_mylist/card_mylist_widget%20copy.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: DrawerHome(),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                user != null ? user.email ?? "Email" : "Email",
                style: TextStyle(fontSize: 6),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "Meus tickets",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<TicketProvider>(
                  builder: (context, ticketProvider, _) {
                    final searchText = _searchController.text.toLowerCase();
                    final filteredTickets =
                        ticketProvider.tickets.where((ticket) {
                      final ticketTitle = ticket.titulo.toLowerCase();
                      return ticketTitle.contains(searchText);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredTickets.length,
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
