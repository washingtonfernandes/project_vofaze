import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardTicketListWidget extends StatelessWidget {
  const CardTicketListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Conserto ar condicionado.",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "Testando todos equipamentos.",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        activeColor: Colors.black,
                        shape: const CircleBorder(),
                        value: true,
                        onChanged: (value) => print(value),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -12),
                    child: Container(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade400,
                          ),
                          Row(
                            children: const [
                              Text("Today"),
                              Gap(12),
                              Text("09:15PM - 11:45PM"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
