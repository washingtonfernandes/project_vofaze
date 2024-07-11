import 'package:flutter/material.dart';

import 'package:project_vofaze/common/cores_dia.dart';


class MyCircle extends StatelessWidget {

  final String child;


  const MyCircle({super.key, required this.child});


  @override

  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(8.0),

      child: Container(

        height: 100,

        width: 100,

        decoration: const BoxDecoration(

          shape: BoxShape.circle,

          color: MinhasCores.amareloTopo,

        ),

        child: Center(child: Text(child, style: const TextStyle(fontSize: 16))),

      ),

    );

  }

}

