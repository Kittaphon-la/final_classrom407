import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'list_screen.dart';

class MainNavigation extends StatefulWidget {

  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int index = 0;

  final pages = [
    const DashboardScreen(),
    const ListScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: index,

        onTap: (i) {
          setState(() {
            index = i;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Equipment",
          ),

        ],

      ),

    );
  }
}