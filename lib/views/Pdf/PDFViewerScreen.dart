import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatelessWidget {
  final String filePath;

  const PDFViewerScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizador de PDF'),
        backgroundColor: Colors.amber,
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
