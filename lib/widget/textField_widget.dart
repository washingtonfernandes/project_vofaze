import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class TextFildWidget extends StatelessWidget {
  const TextFildWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.txtController,
  });

  final String hintText;
  final int maxLine;
  final TextEditingController txtController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MinhasCores.amareloBaixo,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: txtController,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black12,
            )),
        maxLines: maxLine,
      ),
    );
  }
}
