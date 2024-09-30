import 'package:boxigoapp/appbarmain.dart';
import 'package:boxigoapp/bedroomdropdown.dart';
import 'package:boxigoapp/bottomnavigationbar.dart';
import 'package:boxigoapp/customcard.dart';
import 'package:boxigoapp/customitemsdropdown.dart';
import 'package:boxigoapp/dropdownmenu.dart';
import 'package:boxigoapp/floreinfoscreen.dart';
import 'package:boxigoapp/itemsnavbar.dart';
import 'package:boxigoapp/rowone.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsLayout extends StatefulWidget {
  const DetailsLayout({super.key});

  @override
  _DetailsLayoutState createState() => _DetailsLayoutState();
}

class _DetailsLayoutState extends State<DetailsLayout> {
  int _selectedIndex = 0; // Track the currently selected index
  String _selectedItem = 'items'; // Default selected item
  String? estimateId; // Store the estimateId

  Future<Map<String, dynamic>> fetchEstimateData() async {
    final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final estimate = data['Customer_Estimate_Flow'][0]; // Assuming first estimate
      estimateId = estimate['estimate_id']; // Store the estimateId
      return estimate;
    } else {
      throw Exception('Failed to load estimate data');
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchEstimateData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show a loading spinner
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message
          } else {
            final estimate = snapshot.data!; // Use fetched estimate data

            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height, // Give the column a defined height
                child: Column(
                  children: [
                    const ResponsiveRowone(),
                    ItemsNavBar(onItemSelected: _onItemTapped), // Handle item selection
                    _getBodyContent(estimate), // Pass fetched estimate data to content
                  ],
                ),
              ),
            );
          }
        },
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

  // This method gets called when "Floor Info" is selected
  Widget _getBodyContent(Map<String, dynamic> estimate) {
    switch (_selectedItem) {
      case 'Floor Info':
        return DetailsBox(estimateId: estimateId!); // Pass the estimateId to DetailsBox
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
