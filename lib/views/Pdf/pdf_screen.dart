import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/views/Pdf/PDFGeneratorAll.dart';
import 'package:project_vofaze/views/Pdf/PDFGenerator_IsDone.dart';
import 'package:project_vofaze/views/Pdf/PDFGenerator_isDoneNot.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late Future<String> _currentFuture;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _currentFuture = Future.value('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinhasCores.amarelo,
        title: const Text('Relatórios'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundoa_app.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: MinhasCores.amarelo,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _isGenerating
                    ? null
                    : () {
                        _generateReportAndNavigate(context,
                            () => PDFGeneratorAll.generateReportAndPrint());
                      },
                child: const Text(
                  'Relatório Geral',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: MinhasCores.amarelo,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _isGenerating
                    ? null
                    : () {
                        _generateReportAndNavigate(
                            context,
                            () =>
                                PDFGeneratorIsDoneNot.generateReportAndPrint());
                      },
                child: const Text(
                  'Tickets não concluídos',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: MinhasCores.amarelo,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _isGenerating
                    ? null
                    : () {
                        _generateReportAndNavigate(context,
                            () => PDFGeneratorIsDone.generateReportAndPrint());
                      },
                child: const Text(
                  'Tickets concluídos',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),

              // Mostrar indicador de progresso
              if (_isGenerating) ...[
                const SizedBox(height: 16.0),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generateReportAndNavigate(
      BuildContext context, Future<String> Function() generator) async {
    try {
      setState(() {
        _isGenerating = true;
        _currentFuture = generator();
      });

      String filePath = await _currentFuture;

      if (filePath.isNotEmpty) {
        // Aguardar a conclusão do PDF para poder abrir
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PDFView(
              filePath: filePath,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Arquivo PDF não encontrado')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar o relatório')),
      );
      print('Erro ao gerar o relatório: $e');
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }
}
