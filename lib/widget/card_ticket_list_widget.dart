import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:provider/provider.dart';

class CardTicketListWidget extends StatelessWidget {
  const CardTicketListWidget({
    Key? key,
    required this.getIndex,
  }) : super(key: key);

  final int getIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Consumer<TicketProvider>(
        builder: (context, ticketProvider, _) {
          final TicketModel? ticket = ticketProvider.tickets.length > getIndex
              ? ticketProvider.tickets[getIndex]
              : null;
          if (ticket != null) {
            final docID = ticket.docID;
            final getSetor = ticket.setor;
            Color setorColor = Colors.white;

            switch (getSetor) {
              case 'Manut':
                setorColor = Colors.red;
                break;
              case 'Limp':
                setorColor = Colors.blue;
                break;
              case 'Admin':
                setorColor = Colors.green;
                break;
              default:
                setorColor = Colors.white;
                break;
            }

            return Padding(
              // Adicionando padding para espaçamento nas laterais
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
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
                        color: setorColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Excluir o ticket ao pressionar o ícone de deletar
                                if (docID != null) {
                                  ticketProvider.confirmDelete(docID, context);
                                }
                              },
                            ),
                            title: Stack(
                              children: [
                                Text(
                                  ticket.titulo,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (ticket.isDone)
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 12,
                                    child: Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Stack(
                              children: [
                                Text(
                                  ticket.descricao,
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (ticket.isDone)
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 12,
                                    child: Container(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.black,
                              shape: CircleBorder(),
                              value: ticket.isDone,
                              onChanged: (value) {
                                // Atualizar o status do ticket
                                ticketProvider.updateTicketStatus(
                                    ticket, value ?? false);
                              },
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
                                        Text(ticket.data),
                                        Gap(12),
                                        Text(
                                          ticket.horario,
                                        ),
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
              ),
            );
          } else {
            return SizedBox(); // Retorna um widget vazio se o ticket for nulo
          }
        },
      ),
    );
  }
}
