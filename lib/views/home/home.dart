import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/drawer/drawer_home.dart';
import 'package:project_vofaze/views/home/completed_ticket_home.dart';
import 'package:project_vofaze/views/home/pending_ticket_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _searchText;
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchText = '';
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHome(),
      appBar: AppBar(
        backgroundColor: MinhasCores.amareloBaixo,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: MinhasCores.amarelo,
            radius: 20,
            child: Image.asset('assets/images/vofaze3.png'),
          ),
          title: const Text(
            "Olá, bem-vindo",
            style: TextStyle(fontSize: 12),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: FirebaseAuth.instance.currentUser!.reload(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Carregando...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    User? user = FirebaseAuth.instance.currentUser;
                    String displayName = user?.displayName ?? "Nome do Usuário";

                    return Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.exit_to_app_sharp),
            onPressed: () {
              AutenticacaoServico().deslogar();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/fundo_app.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Tickets Pendentes"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Tickets Completados"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: [
                    PendingTicketsScreen(),
                    Container(
                      color: MinhasCores.amarelo,
                      child: CompletedTicketsScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
