import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/AdminEdit/admin_edit.dart';
import 'package:project_vofaze/views/ticketList/ticket_list.dart';
import 'package:project_vofaze/views/unidades/units.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundoa_app.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 30,
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
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TicketList()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Tickets",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: MinhasCores.amarelo,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminEditPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Contato",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminEditPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Relatórios",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminEditPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                  primary: Colors.black,
                ),
                child: Text(
                  "Página Admin",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 60,
                decoration: BoxDecoration(
                  color: MinhasCores.amarelo,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  title: Icon(Icons.exit_to_app),
                  onTap: () {
                    AutenticacaoServico().deslogar();
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
