import 'package:boxigoapp/appbarmain.dart';
import 'package:boxigoapp/bottomnavigationbar.dart';
import 'package:boxigoapp/centerscreen.dart';
import 'package:boxigoapp/logorow.dart';
import 'package:boxigoapp/navbar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0; // Track the currently selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(), // Use your existing AppBarMain
      body: const Column(
        children: [
           ResponsiveRow(), // Add the ResponsiveRow here
           ScrollableNavBar(), // Use your existing ScrollableNavBar
          Expanded(
            child: Center(
             child:  ResponsiveBoxWithColumn(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Pass the handler for tap events
      ),
    );
  }
}
