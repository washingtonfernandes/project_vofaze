import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:project_vofaze/views/cadastroAmbiente/cadastro_ambiente.dart';
import 'package:project_vofaze/views/cadastroSetor/cadastro_setor.dart';
import 'package:project_vofaze/views/cadastroUsuario/cadastro_usuario.dart';

class AdminEditPage extends StatefulWidget {
  @override
  _AdminEditPageState createState() => _AdminEditPageState();
}

class _AdminEditPageState extends State<AdminEditPage> {
  PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administração'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Fecha a página atual
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page.toDouble();
                });
              },
              children: [
                buildCard(CadastroUsuario()),
                buildCard(CadastroAmbiente()),
                buildCard(CadastroSetor()),
              ],
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: _currentPage,
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
        ],
      ),
    );
  }

  Widget buildCard(Widget page) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              35.0), // Ajuste o valor para tornar os cantos mais arredondados
        ),
        elevation: 5.0,
        child: Container(
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
