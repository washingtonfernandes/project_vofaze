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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkAdminStatus();
  }

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
                        onPressed: isAdmin
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TicketList()));
                              }
                            : showNoPermissionMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              isAdmin ? Colors.yellow : Colors.white,
                          backgroundColor: isAdmin ? Colors.black : Colors.grey,
                        ),
                        child: const Text(
                          "Tickets",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: isAdmin
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminEditPage()));
                              }
                            : showNoPermissionMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              isAdmin ? Colors.yellow : Colors.white,
                          backgroundColor: isAdmin ? Colors.black : Colors.grey,
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
                        onPressed: isAdmin
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const PdfScreen()));
                              }
                            : showNoPermissionMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              isAdmin ? Colors.yellow : Colors.white,
                          backgroundColor: isAdmin ? Colors.black : Colors.grey,
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
                      MaterialPageRoute(builder: (context) => const ChatMsg()));
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

  Future<void> checkAdminStatus() async {
    bool adminStatus = await checkIsAdmin();
    setState(() {
      isAdmin = adminStatus;
    });
  }

  Future<bool> checkIsAdmin() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        return data.containsKey('isAdmin') ? data['isAdmin'] : false;
      }
    }
    return false;
  }

  void showNoPermissionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MinhasCores.amarelo,
          title: const Center(
            child: Text(
              'Acesso Negado',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Sem permissão!'),
                  Text('Acesso Administrador.'),
                ],
              ),
            ],
          ),
          actions: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
