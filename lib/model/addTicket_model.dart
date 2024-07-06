import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:project_vofaze/widget/alert_dialog_ticket_widget.dart';

import 'package:project_vofaze/widget/ambiente_selected.dart';

import 'package:project_vofaze/widget/date_time_widget.dart';

import 'package:project_vofaze/widget/radio_widget.dart';

import 'package:project_vofaze/widget/textField_widget.dart';

import 'package:project_vofaze/widget/user_selected.dart';

import 'package:provider/provider.dart';

import '../services/provider/date_time_provider.dart';

import '../services/provider/radio_provider.dart';

import '../common/cores_dia.dart';

class AddTicketModel extends StatefulWidget {
  const AddTicketModel({super.key});

  @override
  State<AddTicketModel> createState() => _AddTicketModelState();
}

class _AddTicketModelState extends State<AddTicketModel> {
  final tituloController = TextEditingController();

  final descricaoController = TextEditingController();

  String selectedUser = "0";

  String selectedAmbiente = "0";

  @override
  Widget build(BuildContext context) {
    // Função para formatar a data

    String formatDate(DateTime? date) {
      return date != null
          ? "${date.day}/${date.month}/${date.year}"
          : "dd/mm/yy";
    }

    // Função para formatar a hora

    String formatTime(TimeOfDay? time) {
      if (time != null) {
        String twoDigits(int n) => n.toString().padLeft(2, '0');

        return '${twoDigits(time.hour)}:${twoDigits(time.minute)}';
      }

      return "hh:mm";
    }

    // Função (primeira letra maiúscula, restante minúscula)

    String capitalize(String input) {
      if (input.isEmpty) {
        return input;
      }

      return input.substring(0, 1).toUpperCase() +
          input.substring(1).toLowerCase();
    }

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.80,
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
                child: const Text(
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
            const Gap(12),
            const Text(
              "Título do ticket",
              style: TextStyle(fontSize: 16),
            ),
            const Gap(6),
            TextFildWidget(
              hintText: 'Adicione um nome ao ticket.',
              maxLine: 1,
              txtController: tituloController,
            ),
            const Gap(6),
            const Text(
              "Descrição",
              style: TextStyle(fontSize: 16),
            ),
            TextFildWidget(
              hintText: 'Descreva o serviço.',
              maxLine: 3,
              txtController: descricaoController,
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserSelectionWidget(
                      selectedUser: selectedUser,
                      onChanged: (value) {
                        setState(() {
                          selectedUser = value!;
                        });
                      },
                    ),
                  ],
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AmbienteSelectionWidget(
                      selectedAmbiente: selectedAmbiente,
                      onChanged: (value) {
                        setState(() {
                          selectedAmbiente = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Gap(12),
            const Text(
              "Setor",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Manut",
                    setorColor: Colors.red,
                    valueInput: 1,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(1),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Limp",
                    setorColor: Colors.blue,
                    valueInput: 2,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(2),
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: "Admin",
                    setorColor: Colors.green,
                    valueInput: 3,
                    onChangeValue: () =>
                        context.read<RadioProvider>().setSelectedRadio(3),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                DateTimeWidget(
                  titleText: "Data",
                  valueText: formatDate(
                      context.read<DateTimeProvider>().selectedDate),
                  iconSection: Icons.calendar_month,
                  onTap: () => _selectDate(context),
                ),
                const Gap(12),
                DateTimeWidget(
                  titleText: "Horário",
                  valueText: formatTime(
                      context.read<DateTimeProvider>().selectedTime),
                  iconSection: Icons.punch_clock_sharp,
                  onTap: () => _selectTime(context),
                ),
              ],
            ),
            const Gap(12),
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
                const Gap(12),
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
                      String formattedTitle = capitalize(tituloController.text);

                      String formattedDescription =
                          capitalize(descricaoController.text);

                      if (formattedTitle.isEmpty ||
                          formattedDescription.isEmpty ||
                          selectedUser == "0" ||
                          selectedAmbiente == "0" ||
                          context.read<RadioProvider>().getSelectedRadio() ==
                              0 ||
                          context.read<DateTimeProvider>().selectedDate ==
                              null ||
                          context.read<DateTimeProvider>().selectedTime ==
                              null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialogTicket();
                          },
                        );
                      } else {
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

                        await FirebaseFirestore.instance
                            .collection("tickets")
                            .add({
                          "titulo": formattedTitle,
                          "descricao": formattedDescription,
                          "setor": setor,
                          "data": formatDate(
                              context.read<DateTimeProvider>().selectedDate),
                          "horario": formatTime(
                              context.read<DateTimeProvider>().selectedTime),
                          "isDone": false,
                          "userId": selectedUser,
                          "ambienteId": selectedAmbiente,
                        });

                        print("Salvo");

                        tituloController.clear();

                        descricaoController.clear();

                        context.read<RadioProvider>().setSelectedRadio(0);

                        Navigator.pop(context);
                      }
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

  // Função para selecionar a data

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeProvider dateTimeProvider = context.read<DateTimeProvider>();

    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            hintColor: Colors.yellowAccent,
            colorScheme: const ColorScheme.light(primary: Colors.black),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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

  // Função para selecionar a hora

  Future<void> _selectTime(BuildContext context) async {
    final DateTimeProvider dateTimeProvider = context.read<DateTimeProvider>();

    final TimeOfDay? picked = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            hintColor: Colors.yellowAccent,
            colorScheme: const ColorScheme.light(primary: Colors.black),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
