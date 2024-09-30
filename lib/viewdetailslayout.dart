import 'package:boxigoapp/appbarmain.dart';
import 'package:boxigoapp/bedroomdropdown.dart';
import 'package:boxigoapp/bottomnavigationbar.dart';
import 'package:boxigoapp/customcard.dart';
import 'package:boxigoapp/customitemsdropdown.dart';
import 'package:boxigoapp/floreinfoscreen.dart';
import 'package:boxigoapp/itemsnavbar.dart';
import 'package:boxigoapp/rowone.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsLayout extends StatefulWidget {
  const DetailsLayout({super.key});

  @override
  _DetailsLayoutState createState() => _DetailsLayoutState();
}

class _DetailsLayoutState extends State<DetailsLayout> {
  int _selectedIndex = 0; // Track the currently selected index
  String _selectedItem = 'items'; // Default selected item
  Future<Map<String, dynamic>>? _detailsFuture; // To hold future data

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    _detailsFuture = fetchDetails();
  }

  Future<Map<String, dynamic>> fetchDetails() async {
    final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/')); // Replace with your API URL

    if (response.statusCode == 200) {
      return json.decode(response.body); // Adjust the parsing as needed
    } else {
      throw Exception('Failed to load details');
    }
  }

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
              Expanded(
                child: _getBodyContent(), // Get the body content based on the selected item
              ),
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

  Widget _getBodyContent() {
    switch (_selectedItem) {
      case 'Floor Info':
        return FutureBuilder<Map<String, dynamic>>(
          future: _detailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              
              // Extract dynamic data from the response
              final oldFloorNo = data['Customer_Estimate_Flow'][0]['old_floor_no'] ?? 'N/A';
              final newFloorNo = data['Customer_Estimate_Flow'][0]['new_floor_no'] ?? 'N/A';
              final packingService = data['Customer_Estimate_Flow'][0]['packing_service'] ?? 'N/A';
              final parkingDistance = data['Customer_Estimate_Flow'][0]['new_parking_distance'] ?? 'N/A';

              // Pass the dynamic data to DetailsBox
              return DetailsBox(
                oldFloorNo: oldFloorNo,
                newFloorNo: newFloorNo,
                packingService: packingService,
                parkingDistance: parkingDistance,
                details: [], // You can populate this based on your data structure
              );
            } else {
              return const Center(child: Text('No data found'));
            }
          },
        );
      case 'items':
        return const Column(
          children: [
            SizedBox(height: 16),
            CustomItemDropdown(),
            BedroomLayout(),
            CustomCard(),
          ],
        ); // Return normal layout for items
      case 'Send Quote':
        return const Center(child: Text('Send Quote content goes here'));
      default:
        return const Center(child: Text('Please select an option'));
    }
  }
}
