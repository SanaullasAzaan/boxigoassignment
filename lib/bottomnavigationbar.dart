// File: lib/bottom_navbar.dart

import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrapping with SafeArea ensures it respects device's safe areas (e.g., bottom notches)
      child: Container(
        height: 60, // Adjust this height as necessary
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Shadow color
              blurRadius: 8, // Amount of blur for the shadow
              spreadRadius: 0, // How far the shadow spreads
              offset: Offset(0, -4), // Offset to place shadow above (y-axis)
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt_outlined),
              label: 'Leads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
          currentIndex: widget.selectedIndex, // Highlight the selected item
          onTap: widget.onItemTapped, // Call the tap handler
          selectedItemColor: Colors.orange, // Highlight selected item in orange
          unselectedItemColor: Colors.grey, // Use grey for unselected items
          backgroundColor: Colors.white, // Set background color to white
          showUnselectedLabels: true, // Show labels for unselected items
          type: BottomNavigationBarType.fixed, // Prevent shifting of icons
        ),
      ),
    );
  }
}
