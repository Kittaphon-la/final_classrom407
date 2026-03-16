import 'package:flutter/material.dart';
import '../models/equipment_model.dart';

class EquipmentTile extends StatelessWidget {

  final Equipment item;

  const EquipmentTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: const Icon(Icons.devices),

        title: Text(item.name),

        subtitle: Text(
          "${item.quantity} ${item.unit} | ${item.status}",
        ),

        trailing: const Icon(Icons.arrow_forward_ios),

      ),

    );
  }
}