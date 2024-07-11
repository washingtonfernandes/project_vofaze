import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/widget/card_ticket_list/card_ticket_list_widget.dart';
import 'package:project_vofaze/model/addTicket_model.dart';
import 'package:gap/gap.dart';

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  late String _searchText;

  @override
  void initState() {
    super.initState();
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.amarelo,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: MinhasCores.amareloBaixo,
          foregroundColor: Colors.black,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: MinhasCores.amarelo,
              radius: 25,
              child: Image.asset('assets/images/vofaze3.png'),
            ),
            title: const Text(
              "Olá, bem-vindo",
              style: TextStyle(fontSize: 12),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: FirebaseAuth.instance.currentUser!.reload(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        "Carregando...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      User? user = FirebaseAuth.instance.currentUser;
                      String displayName =
                          user?.displayName ?? "Nome do Usuário";

                      return Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: FirebaseAuth.instance.currentUser!.reload(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        "Carregando...",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      User? user = FirebaseAuth.instance.currentUser;
                      String email = user?.email ?? "Email";

                      return Text(
                        email,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            trailing: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.black,
              foregroundColor: MinhasCores.amarelo,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  context: context,
                  builder: (context) => const AddTicketModel(),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Manutenção",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Limpeza",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Administrativo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(12),
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
                      ticket.data.toLowerCase().contains(lowerCaseSearchText);
                }).toList();

                return ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) => CardTicketListWidget(
                    getIndex: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
