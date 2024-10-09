import 'package:flutter/material.dart';

class ScrollableNavBar extends StatefulWidget {
  const ScrollableNavBar({super.key});

  @override
  _ScrollableNavBarState createState() => _ScrollableNavBarState();
}

class _ScrollableNavBarState extends State<ScrollableNavBar> {
  String selectedItem = 'Home'; // Track the selected item

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600), // Set max width constraint
      child: Container(
        decoration:const BoxDecoration(
          color: Colors.white, // Background color of the nav bar
          boxShadow: [
            BoxShadow(
              color: Colors.black, // Shadow color
              blurRadius: 8, // Amount of blur for the shadow
              spreadRadius: 0, // How far the shadow spreads
              offset: Offset(0, 4), // Offset the shadow vertically downwards (y-axis)
            ),
          ],
        ),
        height: 40, // Reduced height of the nav bar
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align items to the center vertically
            children: <Widget>[
              _buildNavBarItem('All'),
              _buildNavBarItem('New'),
              _buildNavBarItem('Follow Up'),
              _buildNavBarItem('Booked'),
              _buildNavBarItem('In Track'),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each NavBar item with state management
  Widget _buildNavBarItem(String title) {
    final isSelected = selectedItem == title; // Check if this item is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = title; // Update selected item on tap
        });
      },
      child: Container(
        alignment: Alignment.center, // Center the content inside the Container
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adjusted padding to match reduced height
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.orange : Colors.transparent, // Orange line if selected, else transparent
              width: 2.0, // Reduced thickness of the bottom line
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey, // Change text color based on selection
            fontSize: 14, // Reduced font size to match the new height
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
