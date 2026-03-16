import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatefulWidget {

  final int normal;
  final int low;

  const PieChartWidget({
    super.key,
    required this.normal,
    required this.low,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {

  double animationValue = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animationValue = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder(

      tween: Tween<double>(begin: 0, end: animationValue),
      duration: const Duration(milliseconds: 800),

      builder: (context,value,child){

        return SizedBox(

          height: 220,

          child: PieChart(

            PieChartData(

              centerSpaceRadius: 50,

              sections: [

                PieChartSectionData(
                  value: widget.normal * value,
                  color: Colors.green,
                  title: "ปกติ",
                  radius: 60,
                ),

                PieChartSectionData(
                  value: widget.low * value,
                  color: Colors.red,
                  title: "ใกล้หมด",
                  radius: 60,
                ),

              ],

            ),

          ),

        );

      },

    );
  }
}