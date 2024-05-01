import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:project_vofaze/common/cores_dia.dart'; // Para formatar a data

class PDFScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinhasCores.amarelo,
        title: Text('Relatórios'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MinhasCores.amarelo,
                    ),
                    onPressed: () async {
                      // Obter o contexto atual
                      BuildContext buttonContext = context;

                      final pdf = pw.Document();
                      final ticketsData = await FirebaseFirestore.instance
                          .collection('tickets')
                          .get();

                      // Cabeçalho com imagem de avatar, nome do usuário e data atual
                      final Uint8List avatarImageBytes =
                          (await rootBundle.load('assets/images/vofaze3.png'))
                              .buffer
                              .asUint8List();
                      final User? user = FirebaseAuth.instance.currentUser;
                      final String userName = user != null
                          ? user.displayName ?? "Nome do Usuário"
                          : "Nome do Usuário";
                      final String currentDate =
                          DateFormat('dd/MM/yyyy').format(DateTime.now());

                      // Construir os dados da tabela
                      List<List<dynamic>> tableData = [];

                      for (var ticket in ticketsData.docs) {
                        String ambienteNome = ticket['ambienteId'] != 'Todos'
                            ? await _getAmbienteNome(ticket['ambienteId'])
                            : 'Nome não encontrado';

                        String userName = ticket['userId'] != 'Todos'
                            ? await _getUserName(ticket['userId'])
                            : 'Nome não encontrado';

                        tableData.add([
                          ticket['data'] as String,
                          ticket['setor'] as String,
                          userName as String,
                          ambienteNome as String,
                          ticket['descricao'] as String,
                          ticket['titulo'] as String,
                          ticket['isDone'] ? 'Sim' : 'Não', // Concluído
                        ]);
                      }

                      // Adicionar contagem de concluídos ao final da tabela
                      int concluidosTrue =
                          tableData.where((row) => row[6] == 'Sim').length;
                      int concluidosFalse =
                          tableData.where((row) => row[6] == 'Não').length;

                      pdf.addPage(
                        pw.Page(
                          build: (pw.Context context) {
                            return pw.Container(
                              padding: pw.EdgeInsets.all(20),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Image(pw.MemoryImage(avatarImageBytes),
                                          width: 50),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(userName,
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(currentDate),
                                        ],
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(
                                      height:
                                          10), // Espaçamento entre os elementos

                                  // Segundo Container
                                  pw.Container(
                                    padding:
                                        pw.EdgeInsets.symmetric(vertical: 20),
                                    child: pw.Table(
                                      border: pw.TableBorder.all(),
                                      children: [
                                        for (var row in tableData)
                                          pw.TableRow(
                                            children: [
                                              for (var cell in row)
                                                pw.Container(
                                                  padding: pw.EdgeInsets.all(5),
                                                  child: pw.Text('$cell'),
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(
                                      height:
                                          10), // Espaçamento entre os elementos

                                  // Terceiro Container
                                  pw.Container(
                                    padding: pw.EdgeInsets.only(top: 20),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                            'Total de Concluídos: $concluidosTrue'),
                                        pw.Text(
                                            'Total de Não Concluídos: $concluidosFalse'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );

                      // Salvar o PDF localmente
                      final output = await getExternalStorageDirectory();
                      final file = File('${output?.path}/tickets_report.pdf');
                      await file.writeAsBytes(await pdf.save());

                      // Exibir o PDF gerado utilizando PDFView
                      Navigator.of(buttonContext).push(
                        MaterialPageRoute(
                          builder: (context) => PDFView(
                            filePath: file.path,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Relatório Geral',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Função para obter o nome do ambiente
  Future<String> _getAmbienteNome(String ambienteId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('ambientes')
        .doc(ambienteId)
        .get();
    return snapshot.exists ? snapshot['ambiente'] : 'Nome não encontrado';
  }

  // Função para obter o nome do usuário
  Future<String> _getUserName(String userId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot['nome'] : 'Nome não encontrado';
  }
}
