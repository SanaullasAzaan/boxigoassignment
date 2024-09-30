import 'package:boxigoapp/appbarmain.dart';
import 'package:boxigoapp/bottomnavigationbar.dart';
import 'package:boxigoapp/customcard.dart';
import 'package:boxigoapp/customitemsdropdown.dart';
import 'package:boxigoapp/floreinfoscreen.dart';
import 'package:boxigoapp/itemsnavbar.dart';
import 'package:boxigoapp/rowone.dart';
import 'package:flutter/material.dart';

class DetailsLayout extends StatefulWidget {
  const DetailsLayout({super.key});

  @override
  _DetailsLayoutState createState() => _DetailsLayoutState();
}

class _DetailsLayoutState extends State<DetailsLayout> {
  int _selectedIndex = 0; // Track the currently selected index
  String _selectedItem = 'items'; // Default selected item

  void _onItemTapped(String selectedItem) {
    setState(() {
      _selectedItem = selectedItem; // Update the selected item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarMain(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const ResponsiveRowone(),
              ItemsNavBar(onItemSelected: _onItemTapped), // Handle item selection
              _getBodyContent(), // Get the body content based on the selected item
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }

  // This method returns the body content based on the selected item
  Widget _getBodyContent() {
    switch (_selectedItem) {
      case 'Floor Info':
        return const DetailsBox(
          oldFloorNo: '2', // Example static data
          newFloorNo: '5', // Example static data
          packingService: 'Full Service', // Example static data
          parkingDistance: '20 meters', // Example static data
        ); // Pass static data to DetailsBox
      case 'items':
      default:
        return const Column(
          children: [
            SizedBox(height: 16),
            CustomItemDropdown(),
            CustomCard(),
          ],
        ); // Return normal layout for items
    }
  }
}
