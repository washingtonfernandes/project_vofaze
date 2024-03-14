import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:provider/provider.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    Key? key,
    required this.titleRadio,
    required this.categColor,
    required this.valueInput,
    required void Function() onChangeValue,
  }) : super(key: key);

  final String titleRadio;
  final Color categColor;
  final int valueInput;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, radioProvider, _) {
        return Material(
          color: MinhasCores.amareloBaixo,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: categColor),
            child: RadioListTile(
              activeColor: categColor,
              contentPadding: EdgeInsets.zero,
              title: Transform.translate(
                offset: const Offset(-22, 0),
                child: Text(
                  titleRadio,
                  style: TextStyle(
                    color: categColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              value: valueInput,
              groupValue: radioProvider.getSelectedRadio(),
              onChanged: (value) {
                radioProvider.setSelectedRadio(valueInput);
              },
            ),
          ),
        );
      },
    );
  }
}
