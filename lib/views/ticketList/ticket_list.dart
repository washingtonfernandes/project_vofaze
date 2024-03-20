import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/show_model.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/widget/card_ticket_list_widget.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class TicketList extends StatelessWidget {
  TicketList({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: MinhasCores.amarelo,
      appBar: AppBar(
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
          subtitle: Text(
            user != null
                ? user.displayName ?? "Nome do Usuário"
                : "Nome do Usuário",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month),
              ),
            ]),
          )
        ],
      ),
      body: Column(
        children: [
          const Gap(12),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tickets",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Ordens abertas"),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    context: context,
                    builder: (context) => AddTicketModel(),
                  ),
                  child: Text(
                    "+ Novo Ticket",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: Consumer<TicketProvider>(
              builder: (context, ticketProvider, _) {
                final tickets = ticketProvider.tickets;
                return ListView.builder(
                  controller: _scrollController,
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
