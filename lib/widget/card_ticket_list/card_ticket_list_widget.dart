import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/model/editTicket_model.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:provider/provider.dart';

class CardTicketListWidget extends StatelessWidget {
  const CardTicketListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  Color _getSetorColor(String setor) {
    switch (setor) {
      case 'Manut':
        return Colors.red;
      case 'Limp':
        return Colors.blue;
      case 'Admin':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

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
            return FutureBuilder<DocumentSnapshot>(
              future: _fetchUserData(ticket.userId),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    value: null,
                    strokeWidth: 2,
                    color: Colors.black,
                  );
                }
                if (userSnapshot.hasError) {
                  return const Text('Erro ao carregar dados do usuário');
                }

                final userData =
                    userSnapshot.data?.data() as Map<String, dynamic>?;

                final userName = userData != null
                    ? userData['nome'] != null
                        ? (userData['nome'] as String).length > 10
                            ? userData['nome'].toString().substring(0, 10)
                            : userData['nome'].toString()
                        : 'Todos'
                    : 'Todos';

                return FutureBuilder<DocumentSnapshot>(
                  future: _fetchAmbienteData(ticket.ambienteId),
                  builder: (context, ambienteSnapshot) {
                    if (ambienteSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        value: null,
                        strokeWidth: 2,
                        color: Colors.black,
                      );
                    }
                    if (ambienteSnapshot.hasError) {
                      return const Text('Erro ao carregar dados do ambiente');
                    }

                    final ambienteData =
                        ambienteSnapshot.data?.data() as Map<String, dynamic>?;

                    final ambienteName = ambienteData != null
                        ? ambienteData['ambiente'] != null
                            ? (ambienteData['ambiente'] as String).length > 10
                                ? ambienteData['ambiente']
                                    .toString()
                                    .substring(0, 10)
                                : ambienteData['ambiente'].toString()
                            : 'Todos'
                        : 'Todos';

                    return _buildTicketCard(context, ticket, userName,
                        ambienteName, ticketProvider);
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> _fetchUserData(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
  }

  Future<DocumentSnapshot> _fetchAmbienteData(String ambienteId) async {
    return await FirebaseFirestore.instance
        .collection("ambientes")
        .doc(ambienteId)
        .get();
  }

  Widget _buildTicketCard(BuildContext context, TicketModel ticket,
      String userName, String ambienteName, TicketProvider ticketProvider) {
    Color setorColor = _getSetorColor(ticket.setor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: setorColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      // Nome do usuário
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              const Text("Usuário",
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Column(
                                children: [
                                  const Gap(12),
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Nome do ambiente
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              const Text("Ambiente",
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Column(
                                children: [
                                  const Gap(12),
                                  Text(
                                    ambienteName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    title: Stack(
                      children: [
                        Text(
                          ticket.titulo,
                          style: const TextStyle(
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
                          style: const TextStyle(fontSize: 14),
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
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: ticket.isDone,
                        onChanged: (value) {
                          ticketProvider.updateTicketStatus(ticket, value);
                        },
                        activeColor: const Color.fromARGB(255, 124, 91, 0),
                        inactiveTrackColor: MinhasCores.amarelo,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: MinhasCores.amareloBaixo,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Gap(12),
                                Text(ticket.data),
                                const Gap(12),
                                Text(ticket.horario),
                                const Gap(12),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    if (ticket.docID != null) {
                                      ticketProvider.confirmDelete(
                                          ticket.docID, context);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditTicketScreen(
                                          ticket: ticket,
                                          userId: ticket.userId,
                                        ),
                                      ),
                                    );
                                  },
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
          ],
        ),
      ),
    );
  }
}
