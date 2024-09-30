import 'package:boxigoapp/appbarmain.dart';
import 'package:boxigoapp/bottomnavigationbar.dart';
import 'package:boxigoapp/customcard.dart';
import 'package:boxigoapp/customitemsdropdown.dart';
import 'package:boxigoapp/floreinfoscreen.dart';
import 'package:boxigoapp/itemsnavbar.dart';
import 'package:boxigoapp/rowone.dart';
import 'package:flutter/material.dart';

class FloorMovement extends StatefulWidget {
  const FloorMovement({super.key});

  @override
  _FloorMovementState createState() => _FloorMovementState();
}

class _FloorMovementState extends State<FloorMovement> {
  int _selectedIndex = 0; // Track the currently selected index
  String _selectedItem = 'items'; // Default selected item

  // Simulated static data for demonstration (replace with actual data as needed)
  final String oldFloorNo = '2';
  final String newFloorNo = '5';
  final String packingService = 'Full Service';
  final String parkingDistance = '20 meters';

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
        child: Column(
          children: [
            const ResponsiveRowone(),
            ItemsNavBar(onItemSelected: _onItemTapped),
            _getBodyContent(), // Now we don't need to pass estimate data
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBodyContent() {
    switch (_selectedItem) {
      case 'Floor Info':
        // Pass the necessary static data to DetailsBox
        return DetailsBox(
          oldFloorNo: oldFloorNo,
          newFloorNo: newFloorNo,
          packingService: packingService,
          parkingDistance: parkingDistance, details: const [],
        );
      case 'items':
      default:
        return const Column(
          children: [
            SizedBox(height: 16),
            CustomItemDropdown(),
            CustomCard(),
          ],
        );
    }
  }
}
