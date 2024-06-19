import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/date_time_provider.dart'; 
import 'package:provider/provider.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.iconSection,
    required this.onTap,
    required String valueText,
  });

  final String titleText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(titleText),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: const BoxDecoration(
                color: MinhasCores.amareloBaixo,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(iconSection),
                      const Gap(6),
                      Consumer<DateTimeProvider>(
                        builder: (context, dateTimeProvider, child) {
                          return Text(
                            titleText == "Data"
                                ? _formatDate(dateTimeProvider.selectedDate)
                                : _formatTime(dateTimeProvider.selectedTime),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? "${date.day}/${date.month}/${date.year}" : "dd/mm/yy";
  }

  String _formatTime(TimeOfDay? time) {
    if (time != null) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      return '${twoDigits(time.hour)}:${twoDigits(time.minute)}';
    }
    return "hh:mm";
  }
}
