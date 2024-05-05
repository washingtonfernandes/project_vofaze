import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:provider/provider.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.setorColor,
    required this.valueInput,
    required void Function() onChangeValue,
  });

  final String titleRadio;
  final Color setorColor;
  final int valueInput;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, radioProvider, _) {
        return Material(
          color: Colors.transparent,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: setorColor),
            child: RadioListTile(
              activeColor: setorColor,
              contentPadding: EdgeInsets.zero,
              title: Transform.translate(
                offset: const Offset(-22, 0),
                child: Text(
                  titleRadio,
                  style: TextStyle(
                    color: setorColor,
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
