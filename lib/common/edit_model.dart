import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/date_time_provider.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/widget/date_time_widget.dart';
import 'package:project_vofaze/widget/radio_widget.dart';
import 'package:provider/provider.dart';

class EditTicketScreen extends StatefulWidget {
  final TicketModel? ticket;

  const EditTicketScreen({Key? key, this.ticket}) : super(key: key);

  @override
  State<EditTicketScreen> createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    if (widget.ticket != null) {
      _tituloController =
          TextEditingController(text: widget.ticket!.titulo ?? '');
      _descricaoController =
          TextEditingController(text: widget.ticket!.descricao ?? '');
    } else {
      _tituloController = TextEditingController();
      _descricaoController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime? date) {
      return date != null
          ? "${date.day}/${date.month}/${date.year}"
          : "dd/mm/yy";
    }

    String _formatTime(TimeOfDay? time) {
      if (time != null) {
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        return '${twoDigits(time.hour)}:${twoDigits(time.minute)}';
      }
      return "hh:mm";
    }

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fundo_app.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: MinhasCores.amareloTopo,
                  borderRadius: BorderRadius.circular(24),
                ),
                //-----------------------------------------
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: MinhasCores.amarelo,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Text(
                            "Editar Ticket",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Gap(12),
                      Text(
                        "Título do ticket",
                        style: TextStyle(fontSize: 16),
                      ),
                      Gap(6),
                      Card(
                        elevation: 0,
                        child: TextField(
                          controller: _tituloController,
                          decoration: InputDecoration(
                            hintText: 'Adicione um nome ao ticket.',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Gap(6),
                      Text(
                        "Descrição",
                        style: TextStyle(fontSize: 16),
                      ),
                      Card(
                        elevation: 0,
                        child: TextField(
                          controller: _descricaoController,
                          decoration: InputDecoration(
                            hintText: 'Descreva o serviço.',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Gap(12),
                      Text(
                        "Setor",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioWidget(
                              titleRadio: "Manut",
                              setorColor: Colors.red,
                              valueInput: 1,
                              onChangeValue: () => context
                                  .read<RadioProvider>()
                                  .setSelectedRadio(1),
                            ),
                          ),
                          Expanded(
                            child: RadioWidget(
                              titleRadio: "Limp",
                              setorColor: Colors.blue,
                              valueInput: 2,
                              onChangeValue: () => context
                                  .read<RadioProvider>()
                                  .setSelectedRadio(2),
                            ),
                          ),
                          Expanded(
                            child: RadioWidget(
                              titleRadio: "Admin",
                              setorColor: Colors.green,
                              valueInput: 3,
                              onChangeValue: () => context
                                  .read<RadioProvider>()
                                  .setSelectedRadio(3),
                            ),
                          ),
                        ],
                      ),
                      Gap(12),
                      Row(
                        children: [
                          DateTimeWidget(
                            titleText: "Data",
                            valueText: _formatDate(
                                context.read<DateTimeProvider>().selectedDate),
                            iconSection: Icons.calendar_month,
                            onTap: () => _selectDate(context),
                          ),
                          Gap(12),
                          DateTimeWidget(
                            titleText: "Horário",
                            valueText: _formatTime(
                                context.read<DateTimeProvider>().selectedTime),
                            iconSection: Icons.punch_clock_sharp,
                            onTap: () => _selectTime(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MinhasCores.amarelo,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "CANCELAR",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                final getRadioValue = context
                                    .read<RadioProvider>()
                                    .getSelectedRadio();
                                String setor = " ";

                                switch (getRadioValue) {
                                  case 1:
                                    setor = "Manut";
                                    break;
                                  case 2:
                                    setor = "Limp";
                                    break;
                                  case 3:
                                    setor = "Admin";
                                    break;
                                }

                                final updatedTicket = TicketModel(
                                  docID: widget.ticket!.docID,
                                  titulo: _tituloController.text,
                                  descricao: _descricaoController.text,
                                  setor: setor,
                                  data: _formatDate(context
                                      .read<DateTimeProvider>()
                                      .selectedDate),
                                  horario: _formatTime(context
                                      .read<DateTimeProvider>()
                                      .selectedTime),
                                  isDone: widget.ticket!.isDone,
                                );

                                context
                                    .read<TicketProvider>()
                                    .updateTicket(updatedTicket);
                                print("Salvo");

                                _tituloController.clear();
                                _descricaoController.clear();
                                context
                                    .read<RadioProvider>()
                                    .setSelectedRadio(0);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "SALVAR",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeProvider dateTimeProvider = context.read<DateTimeProvider>();

    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            hintColor: Colors.yellowAccent,
            colorScheme: ColorScheme.light(primary: Colors.black),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: dateTimeProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      dateTimeProvider.setSelectedDate(picked);
      print('Date picked: ${picked.toLocal()}');
      print(
          'Selected date in provider: ${dateTimeProvider.selectedDate?.toLocal()}');
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTimeProvider dateTimeProvider = context.read<DateTimeProvider>();

    final TimeOfDay? picked = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            hintColor: Colors.yellowAccent,
            colorScheme: ColorScheme.light(primary: Colors.black),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: dateTimeProvider.selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      dateTimeProvider.setSelectedTime(picked);
      print('Time picked: ${picked.format(context)}');
      print(
          'Selected time in provider: ${dateTimeProvider.selectedTime?.format(context)}');
    }
  }
}
