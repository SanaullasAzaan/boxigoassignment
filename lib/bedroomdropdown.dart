import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({super.key});

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  bool isDropdownOpen = false; // Track whether dropdown is open or closed
  List<Map<String, String>> dropdownItems = []; // List to hold fetched items with details

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget initializes
  }

  // Fetch data from API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final inventory = data['Customer_Estimate_Flow'][0]['items']['inventory'];

      // Clear previous items
      dropdownItems.clear();

      for (var item in inventory) {
        final categories = item['category'];
        for (var category in categories) {
          final items = category['items'];
          for (var detail in items) {
            // Fetch the size options
            List<dynamic> sizes = detail['size'] ?? []; // Use an empty list if size is null
            String selectedSize = 'Not available';

            // Check which size option is selected (i.e., where selected is true)
            for (var sizeOption in sizes) {
              if (sizeOption['selected'] == true) {
                selectedSize = '${sizeOption['option']} (${sizeOption['tooltip']})'; // Format: small (<4 ft)
                break;
              }
            }

            // Safely access other fields like typeOptions
            String typeOptions = detail['typeOptions'] ?? 'No type options available';

            // Add displayName, typeOptions, and selected size to the dropdownItems list
            dropdownItems.add({
              'displayName': detail['displayName'] ?? 'No display name', // Provide a default for displayName
              'typeOptions': typeOptions,
              'sizes': selectedSize, // Use the selected size
            });
          }
        }
      }

      // Trigger a rebuild after fetching data
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Optional padding around the column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align title and content to the start
        children: [
          // Title and arrow container with grey background
          Container(
            color: Colors.grey[300], // Set grey background for the title and icon
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding for the title and arrow
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and arrow
              children: [
                // Title at the left end
                const Text(
                  'Living Room', // Static title that doesn't change
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange, // Orange title color
                  ),
                ),
                // Arrow button at the right end
                IconButton(
                  icon: Icon(
                    isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, // Change arrow icon
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      isDropdownOpen = !isDropdownOpen; // Toggle dropdown visibility
                    });
                  },
                ),
              ],
            ),
          ),

          // Dropdown items displayed only when isDropdownOpen is true
          if (isDropdownOpen)
            Container(
              width: double.infinity, // Full width of the screen
              color: Colors.white, // Background color of the dropdown menu
              child: Column(
                children: [
                  // The "Furniture" title inside the dropdown, aligned to the left
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the start (left)
                      child: const Text(
                        'Furniture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Title text color
                        ),
                      ),
                    ),
                  ),

                  // The list of items - Limited to the first 7 items
                  ...dropdownItems.take(7).map((Map<String, String> item) { // Limit to 7 items
                    return _buildCustomRow(
                      icon: Icons.star, // Use a default icon or customize per item
                      title: item['displayName'] ?? '', // Use the dynamically fetched display name
                      subtitle: '${item['typeOptions']} | Size: ${item['sizes']}', // Use fetched typeOptions and selected size
                      trailingNumber: '1', // Customize this as needed
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build a custom row
  Widget _buildCustomRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailingNumber,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside each item
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and trailing number
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.orange), // Icon at the start of the row
              const SizedBox(width: 8), // Space between icon and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14, // Title font size
                      fontWeight: FontWeight.bold, // Bold title
                      color: Colors.black, // Text color
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12, // Subtitle font size
                      fontWeight: FontWeight.normal, // Normal weight
                      color: Colors.grey, // Subtitle color
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            trailingNumber,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color for number
            ),
          ),
        ],
      ),
    );
  }
}
