import 'package:flutter/material.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/service_provider.dart';
import 'package:provider/provider.dart';

class CardTicketListWidget extends StatelessWidget {
  const CardTicketListWidget({
    Key? key,
    required this.getIndex,
  }) : super(key: key);

  final int getIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(
      builder: (context, ticketProvider, _) {
        final tickets = ticketProvider.tickets;
        if (tickets.isEmpty) {
          return const Center(
            child: Text("No data available"),
          );
        } else if (tickets.length <= getIndex) {
          return const SizedBox(); // Retorna um widget vazio se o índice estiver fora dos limites
        } else {
          final TicketModel ticket = tickets[getIndex];
          return Center(
            child: ListTile(
              title: Text(ticket.titulo),
              subtitle: Text(ticket.descricao),
              // Adicione outros campos do ticket conforme necessário
            ),
          );
        }
      },
    );
  }
}
