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
  const Home({Key? key}) : super(key: key);

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
              Column(children: [
                Container(
                  color: Colors.transparent,
                  child: Center(
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioWidget(
                          titleRadio: "Manut",
                          setorColor: Colors.red,
                          valueInput: 1,
                          onChangeValue: () =>
                              context.read<RadioProvider>().setSelectedRadio(1),
                        ),
                      ),
                      Expanded(
                        child: RadioWidget(
                          titleRadio: "Limp",
                          setorColor: Colors.blue,
                          valueInput: 2,
                          onChangeValue: () =>
                              context.read<RadioProvider>().setSelectedRadio(2),
                        ),
                      ),
                      Expanded(
                        child: RadioWidget(
                          titleRadio: "Admin",
                          setorColor: Colors.green,
                          valueInput: 3,
                          onChangeValue: () =>
                              context.read<RadioProvider>().setSelectedRadio(3),
                        ),
                      ),
                    ],
                  ),
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
