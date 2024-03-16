import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        if (ticketProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (ticketProvider.error != null) {
          return Center(
            child: Text("Erro ao carregar dados: ${ticketProvider.error}"),
          );
        } else if (ticketProvider.tickets.isEmpty) {
          return Center(
            child: Text("Sem dados"),
          );
        } else if (ticketProvider.tickets.length <= getIndex) {
          return SizedBox();
        } else {
          final TicketModel ticket = ticketProvider.tickets[getIndex];
          return Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  width: 40,
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          ticket.titulo,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        subtitle: Text(
                          ticket.descricao,
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.black,
                            shape: CircleBorder(),
                            value: ticket.isDone,
                            onChanged: (value) => print(value),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -12),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.black38,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(ticket.data), // Exibir a data
                                    Gap(12),
                                    Text(ticket.horario), // Exibir o horário
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
