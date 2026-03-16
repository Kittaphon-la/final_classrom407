import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {

  final String title;
  final int value;

  const StatCard({
    super.key,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}