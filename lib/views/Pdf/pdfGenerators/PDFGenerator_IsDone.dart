import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:printing/printing.dart';

class PDFGeneratorIsDone {
  static Future<String> generateReportAndPrint() async {
    final pdfPath = await generateReport();

    if (pdfPath.isNotEmpty) {
      // Imprimir o PDF
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
        final pdfBytes = File(pdfPath).readAsBytesSync();
        return pdfBytes;
      });

      return pdfPath;
    } else {
      throw Exception('Falha ao gerar o relatório PDF');
    }
  }

  static Future<String> generateReport() async {
    final pdf = pw.Document();
    final ticketsData =
        await FirebaseFirestore.instance.collection('tickets').get();

    // Imagem da logo
    final ByteData imageData =
        await rootBundle.load('assets/images/vofaze3.png');
    final Uint8List avatarImageBytes = imageData.buffer.asUint8List();

    // Informações do usuário
    final User? user = FirebaseAuth.instance.currentUser;
    final String userName = user?.displayName ?? "Nome do Usuário";
    final String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    // Dados da tabela apenas com tickets concluídos
    List<List<dynamic>> tableData = [];

    for (var ticket in ticketsData.docs) {
      bool isDone = ticket['isDone'] ?? false;
      if (isDone) {
        String ambienteNome = await _getAmbienteNome(ticket['ambienteId']);
        String userName = await _getUserName(ticket['userId']);

        tableData.add([
          ticket['data'] as String,
          ticket['setor'] as String,
          userName,
          ambienteNome,
          ticket['descricao'] as String,
          ticket['titulo'] as String,
          isDone ? 'Sim' : 'Não',
        ]);
      }
    }

    // Ordenar a lista pela DATA
    tableData.sort((a, b) => DateFormat('dd/MM/yyyy')
        .parse(a[0])
        .compareTo(DateFormat('dd/MM/yyyy').parse(b[0])));

    // Contagem de tickets concluídos
    int ticketsConcluidos = tableData.length;

    // Construir o conteúdo do PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Cabeçalho com imagem, nome e data
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Image(pw.MemoryImage(avatarImageBytes), width: 50),
                    pw.SizedBox(width: 10),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(userName,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(currentDate),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),

                // Tabela com os dados em ordem
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 20),
                  child: pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(70),
                      1: const pw.FixedColumnWidth(100),
                      2: const pw.FixedColumnWidth(120),
                      3: const pw.FixedColumnWidth(120),
                      4: const pw.FixedColumnWidth(150),
                      5: const pw.FixedColumnWidth(100),
                      6: const pw.FixedColumnWidth(70),
                    },
                    children: [
                      // Títulos das colunas
                      pw.TableRow(
                        children: [
                          for (var header in [
                            'Data',
                            'Setor',
                            'Usuário',
                            'Ambiente',
                            'Descrição',
                            'Título',
                            'Concluído'
                          ])
                            pw.Text(header,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      // Linhas da tabela
                      for (var row in tableData)
                        pw.TableRow(
                          children: [
                            for (var cell in row)
                              pw.Container(
                                padding: const pw.EdgeInsets.all(5),
                                child: pw.Text(
                                  '$cell',
                                  style: const pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10),

                // Total de tickets concluídos
                pw.Text('Total de Tickets Concluídos: $ticketsConcluidos'),
              ],
            ),
          );
        },
      ),
    );

    // Salvar o PDF
    final outputDir = await getExternalStorageDirectory();
    final filePath = '${outputDir?.path}/tickets_concluidos_report.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  static Future<String> _getAmbienteNome(String ambienteId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('ambientes')
        .doc(ambienteId)
        .get();
    return snapshot.exists ? snapshot['ambiente'] : 'Nome não encontrado';
  }

  static Future<String> _getUserName(String userId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot['nome'] : 'Nome não encontrado';
  }
}
