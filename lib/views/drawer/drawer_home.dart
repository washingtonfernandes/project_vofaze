import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/AdminEdit/admin_edit.dart';
import 'package:project_vofaze/views/Pdf/pdf_screen.dart';
import 'package:project_vofaze/views/Sobre/sobre.dart';
import 'package:project_vofaze/views/chat/chat.dart';
import 'package:project_vofaze/views/ticketList/ticket_list.dart';
import 'package:project_vofaze/views/updateUser/update_user.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundoa_app.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: MinhasCores.amarelo,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/vofaze3.png"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TicketList()));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Tickets",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: MinhasCores.amarelo,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminEditPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Cadastros",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Relatórios",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateProfileScreen()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: const SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      Gap(8),
                      Text(
                        "Meu perfil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatMsg()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: const SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat),
                      Gap(8),
                      Text(
                        "Chat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SobrePage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: const SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(8),
                      Text(
                        "Sobre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              Container(
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: ListTile(
                    title: const Icon(
                      Icons.exit_to_app,
                      color: MinhasCores.amarelo,
                    ),
                    onTap: () {
                      AutenticacaoServico().deslogar();
                    },
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
