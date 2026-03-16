
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/equipment_provider.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EquipmentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Room 407 Equipment",

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.indigo,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),

      themeMode: ThemeMode.system,

      home: const MainNavigation(),
    );
  }
}