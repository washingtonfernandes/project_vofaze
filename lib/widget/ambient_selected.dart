import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/common/cores_dia.dart';

class AmbienteSelectionWidget extends StatelessWidget {
  final String selectedAmbiente;
  final ValueChanged<String?>? onChanged;

  const AmbienteSelectionWidget({super.key, 
    required this.selectedAmbiente,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ambientes",
          style: TextStyle(fontSize: 16),
        ),
        Container(
          decoration: BoxDecoration(
            color: MinhasCores.amareloBaixo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("ambientes").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    value: null,
                    strokeWidth: 2,
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return const Text("Erro ao carregar dados do ambiente");
                } else {
                  List<DropdownMenuItem<String>> ambienteItems = [];
                  final ambientes = snapshot.data?.docs.reversed.toList();

                  ambienteItems.add(
                    const DropdownMenuItem(
                      value: "0",
                      child: Text("Ambiente"),
                    ),
                  );

                  for (var ambiente in ambientes!) {
                    ambienteItems.add(
                      DropdownMenuItem(
                        value: ambiente.id,
                        child: Text(ambiente['ambiente']),
                      ),
                    );
                  }

                  return DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black38),
                    underline: Container(
                      height: 2,
                      color: Colors.black12,
                    ),
                    items: ambienteItems,
                    onChanged: onChanged,
                    value: selectedAmbiente,
                    isExpanded: false,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}