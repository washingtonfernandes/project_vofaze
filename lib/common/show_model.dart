import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:project_vofaze/services/provider/service_provider.dart';
import 'package:project_vofaze/services/ticket_service.dart';
import 'package:project_vofaze/widget/date_time_widget.dart';
import 'package:project_vofaze/widget/radio_widget.dart';
import 'package:project_vofaze/widget/textField_widget.dart';
import 'package:provider/provider.dart';

import '../services/provider/date_time_provider.dart';
import 'cores_dia.dart';

class AddTicketModel extends StatefulWidget {
  @override
  State<AddTicketModel> createState() => _AddTicketModelState();
}

class _AddTicketModelState extends State<AddTicketModel> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

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

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: MinhasCores.amareloTopo,
        borderRadius: BorderRadius.circular(24),
      ),
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
                  "Novo Ticket",
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
            const Text(
              "Título do ticket",
              style: TextStyle(fontSize: 16),
            ),
            Gap(6),
            TextFildWidget(
              hintText: 'Adicione um nome ao ticket.',
              maxLine: 1,
              txtController: tituloController,
            ),
            Gap(6),
            const Text(
              "Descrição",
              style: TextStyle(fontSize: 16),
            ),
            TextFildWidget(
              hintText: 'Descreva o serviço.',
              maxLine: 3,
              txtController: descricaoController,
            ),
            Gap(12),
            const Text(
              "Setor",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Manut",
                    categColor: Colors.green,
                    valueInput: 1,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(1),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Limp",
                    categColor: Colors.blue,
                    valueInput: 2,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(2),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Admin",
                    categColor: Colors.red,
                    valueInput: 3,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(3),
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
            Gap(12),
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
                    child: const Text(
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
                      final getRadioValue =
                          context.read<RadioProvider>().getSelectedRadio();
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

                      context.read<TicketService>().addTicket(
                            TicketModel(
                              titulo: tituloController.text,
                              descricao: descricaoController.text,
                              setor: setor,
                              data: _formatDate(context
                                  .read<DateTimeProvider>()
                                  .selectedDate),
                              horario: _formatTime(context
                                  .read<DateTimeProvider>()
                                  .selectedTime),
                            ),
                          );
                      print("Salvo");

                      tituloController.clear();
                      descricaoController.clear();
                      context.read<RadioProvider>().setSelectedRadio(0);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "CRIAR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
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
