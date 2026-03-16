import 'package:flutter/material.dart';
import '../models/equipment_model.dart';

class DetailScreen extends StatelessWidget {

  final Equipment item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("รายละเอียดอุปกรณ์"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("ชื่อ: ${item.name}",
                style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 10),

            Text("ประเภท: ${item.type}"),

            Text("จำนวน: ${item.quantity} ${item.unit}"),

            Text("สถานะ: ${item.status}"),

            Text("วันที่บันทึก: ${item.date}"),

            Text("หมายเหตุ: ${item.note}")

          ],
        ),

      ),

    );
  }
}