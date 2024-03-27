import 'package:flutter/material.dart';


import 'package:gap/gap.dart';


import 'package:project_vofaze/common/edit_model.dart';


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

              padding: const EdgeInsets.symmetric(horizontal: 16.0),

              child: Container(

                //Tamanho do card


                width: double.infinity,


                height: 150,


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

                                ticketProvider.updateTicketStatus(

                                    ticket, value ?? false);

                              },

                            ),

                          ),


                          //Divisão parte de baixo---------------------


                          Transform.translate(

                            offset: Offset(0, -12),

                            child: Container(

                              child: Column(

                                children: [

                                  Divider(

                                    thickness: 1.5,

                                    color: Colors.black38,

                                  ),

                                  Row(

                                    children: [

                                      Gap(16),

                                      Text(ticket.data),

                                      Gap(12),

                                      Text(

                                        ticket.horario,

                                      ),

                                      Gap(36),

                                      IconButton(

                                        icon: Icon(Icons.delete),

                                        onPressed: () {

                                          if (docID != null) {

                                            ticketProvider.confirmDelete(

                                                docID, context);

                                          }

                                        },

                                      ),

                                      Gap(12),

                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTicketScreen(
                                                      ticket: ticket),
                                            ),
                                          );
                                        },
                                      ),

                                    ],

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

            return SizedBox();

          }

        },

      ),

    );

  }

}

