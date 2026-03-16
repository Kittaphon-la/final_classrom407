import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/equipment_provider.dart';
import '../widgets/pie_chart_widget.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EquipmentProvider>(context);

    int total = provider.equipments.length;
    int low = provider.equipments.where((e)=>e.quantity<=2).length;
    int normal = provider.equipments.where((e)=>e.quantity>2).length;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Room 407 Dashboard"),
      ),

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xFFEEF2F7),
              Color(0xFFDCE3F0)
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),

        ),

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

              PieChartWidget(
                normal: normal,
                low: low,
              ),

              const SizedBox(height: 20),

              glassCard("อุปกรณ์ทั้งหมด", total),
              glassCard("ใกล้หมด", low),
              glassCard("ปกติ", normal),

            ],

          ),

        ),

      ),

    );
  }

  Widget glassCard(String title,int value){

    return Padding(

      padding: const EdgeInsets.symmetric(vertical:8),

      child: ClipRRect(

        borderRadius: BorderRadius.circular(16),

        child: BackdropFilter(

          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

          child: Container(

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(

              color: Colors.white.withOpacity(0.3),

              borderRadius: BorderRadius.circular(16),

              border: Border.all(
                color: Colors.white.withOpacity(0.4)
              ),

            ),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(title,
                    style: const TextStyle(fontSize:16)),

                Text(
                  value.toString(),
                  style: const TextStyle(
                      fontSize:22,
                      fontWeight: FontWeight.bold),
                ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}