import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/provider/date_time_provider.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:project_vofaze/widget/ambient_selected.dart';
import 'package:project_vofaze/widget/date_time_widget.dart';
import 'package:project_vofaze/widget/radio_widget.dart';
import 'package:project_vofaze/widget/user_selected.dart';
import 'package:provider/provider.dart';

class EditTicketScreen extends StatefulWidget {
  final TicketModel? ticket;
  final String userId;

  const EditTicketScreen({super.key, this.ticket, required this.userId});

  @override
  State<EditTicketScreen> createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  String selectedUser = "0";
  String selectedAmbiente = "0";

  @override
  void initState() {
    super.initState();
    _tituloController =
        TextEditingController(text: widget.ticket?.titulo ?? '');
    _descricaoController =
        TextEditingController(text: widget.ticket?.descricao ?? '');
    selectedUser = widget.ticket?.userId ?? "0";
    selectedAmbiente = widget.ticket?.ambienteId ?? "0";

    // Delay a chamada da função de inicialização
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDateTimeProviderValues();
    });
  }

  void _initializeDateTimeProviderValues() {
    switch (widget.ticket?.setor) {
      case "Manut":
        context.read<RadioProvider>().setSelectedRadio(1);
        break;
      case "Limp":
        context.read<RadioProvider>().setSelectedRadio(2);
        break;
      case "Admin":
        context.read<RadioProvider>().setSelectedRadio(3);
        break;
      default:
        context.read<RadioProvider>().setSelectedRadio(0);
    }

    // Parse da data e horário
    if (widget.ticket?.data != null) {
      DateTime parsedDate = _parseDateString(widget.ticket!.data);
      context.read<DateTimeProvider>().setSelectedDate(parsedDate);
    }

    if (widget.ticket?.horario != null) {
      List<String> timeComponents = widget.ticket!.horario.split(':');
      TimeOfDay selectedTime = TimeOfDay(
          hour: int.parse(timeComponents[0]),
          minute: int.parse(timeComponents[1]));
      context.read<DateTimeProvider>().setSelectedTime(selectedTime);
    }
  }

  // Tratamento dados data e time
  DateTime _parseDateString(String dateString) {
    List<String> dateComponents = dateString.split('/');
    int day = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int year = int.parse(dateComponents[2]);

    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime? date) {
      return date != null
          ? "${date.day}/${date.month}/${date.year}"
          : "dd/mm/yy";
    }

    String formatTime(TimeOfDay? time) {
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fundo_app.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.74,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
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
                          child: const Text(
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
                      const SizedBox(height: 12),
                      const Text(
                        "Título do ticket",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            controller: _tituloController,
                            decoration: const InputDecoration(
                              hintText: 'Adicione um nome ao ticket.',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Descrição",
                        style: TextStyle(fontSize: 16),
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            controller: _descricaoController,
                            decoration: const InputDecoration(
                              hintText: 'Descreva o serviço.',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
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
                      const SizedBox(height: 12),
                      const Text(
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
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          DateTimeWidget(
                            titleText: "Data",
                            valueText: formatDate(
                                context.read<DateTimeProvider>().selectedDate),
                            iconSection: Icons.calendar_month,
                            onTap: () => _selectDate(context),
                          ),
                          const SizedBox(width: 12),
                          DateTimeWidget(
                            titleText: "Horário",
                            valueText: formatTime(
                                context.read<DateTimeProvider>().selectedTime),
                            iconSection: Icons.punch_clock_sharp,
                            onTap: () => _selectTime(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "SAIR",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                String setor = "Manut";

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
                                  data: formatDate(context
                                      .read<DateTimeProvider>()
                                      .selectedDate),
                                  horario: formatTime(context
                                      .read<DateTimeProvider>()
                                      .selectedTime),
                                  isDone: widget.ticket!.isDone,
                                  userId: selectedUser,
                                  ambienteId: selectedAmbiente,
                                );
                                context
                                    .read<TicketProvider>()
                                    .confirmUpdate(updatedTicket, context);
                              },
                              child: const Text(
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
    }
  }
}
