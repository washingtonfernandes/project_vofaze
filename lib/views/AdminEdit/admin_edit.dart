import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/views/registerAmbient/register_ambient.dart';
import 'package:project_vofaze/views/registerUser/resgister_user.dart';

class AdminEditPage extends StatefulWidget {
  const AdminEditPage({super.key});

  @override
  _AdminEditPageState createState() => _AdminEditPageState();
}

class _AdminEditPageState extends State<AdminEditPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  bool _isUserSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.amareloTopo,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: MinhasCores.amareloBaixo,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: MinhasCores.amarelo,
              radius: 25,
              child: Image.asset('assets/images/vofaze3.png'),
            ),
            title: const Text(
              "Cadastros",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(
        children: [
          // Navegação

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  _isUserSelected = index == 0;

                  _pageController.animateToPage(
                    _isUserSelected ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                });
              },
              isSelected: [_isUserSelected, !_isUserSelected],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              selectedColor: Colors.black,
              fillColor: MinhasCores.amarelo,
              borderColor: Colors.black,
              borderWidth: 1,
              selectedBorderColor: Colors.black,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Usuários',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _isUserSelected ? Colors.black : Colors.black26,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Ambientes',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: !_isUserSelected ? Colors.black : Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Conteúdo das páginas

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;

                  _isUserSelected = page == 0;
                });
              },
              children: [
                buildCard(const CadastroUsuario()),
                buildCard(const CadastroAmbiente())
              ],
            ),
          ),

          // Indicador de páginas

          Container(
            color: MinhasCores.amarelo,
            child: DotsIndicator(
              dotsCount: 2,
              position: _currentPage.toDouble().round(),
              decorator: DotsDecorator(
                size: const Size.square(8.0),
                activeSize: const Size(20.0, 8.0),
                color: Colors.black26,
                activeColor: Colors.black,
                spacing: const EdgeInsets.all(3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(Widget page) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: MinhasCores.amarelo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: page,
          ),
        ),
      ),
    );
  }
}
