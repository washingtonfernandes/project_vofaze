import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/widget/card_mylist/card_mylist_widget.dart';
import 'package:provider/provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';

class CompletedTicketsScreen extends StatelessWidget {
  const CompletedTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: MinhasCores.amareloBaixo,
          title: const Center(
            child: Text(
              'Tickets Concluídos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: Container(
        color: MinhasCores.amarelo,
        child: Consumer<TicketProvider>(
          builder: (context, ticketProvider, _) {
            final tickets = ticketProvider.tickets
                .where((ticket) => ticket.isDone)
                .toList();

            if (tickets.isEmpty) {
              return const Center(child: Text('Nenhum ticket concluído.'));
            }

            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) => CardMyListWidget(
                ticket: tickets[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
