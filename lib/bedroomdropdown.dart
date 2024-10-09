import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BedroomLayout extends StatefulWidget {
  const BedroomLayout({super.key});

  @override
  _BedroomLayoutState createState() => _BedroomLayoutState();
}

class _BedroomLayoutState extends State<BedroomLayout> {
  bool isDropdownOpen = false;
  List<Map<String, String>> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch data from API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final inventory = data['Customer_Estimate_Flow'][0]['items']['inventory'];

        dropdownItems.clear();

        for (var item in inventory) {
          final categories = item['category'];
          for (var category in categories) {
            final items = category['items'];
            for (var detail in items) {
              List<dynamic> sizes = detail['size'] ?? [];
              String selectedSize = 'Not available';

              for (var sizeOption in sizes) {
                if (sizeOption['selected'] == true) {
                  selectedSize = '${sizeOption['option']} (${sizeOption['tooltip']})';
                  break;
                }
              }

              String typeOptions = detail['typeOptions'] ?? 'No type options available';

              dropdownItems.add({
                'displayName': detail['displayName'] ?? 'No display name',
                'typeOptions': typeOptions,
                'sizes': selectedSize,
              });
            }
          }
        }

        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {});
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e); // Handle exceptions, possibly show an error message
    }
  }

  @override
  void dispose() {
    // Clean up resources here if needed (e.g., cancel timers, listeners)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bedroom',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      isDropdownOpen = !isDropdownOpen;
                    });
                  },
                ),
              ],
            ),
          ),
          if (isDropdownOpen)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Furniture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ...dropdownItems.take(7).map((Map<String, String> item) {
                    return _buildCustomRow(
                      icon: Icons.star,
                      title: item['displayName'] ?? '',
                      subtitle: '${item['typeOptions']} | Size: ${item['sizes']}',
                      trailingNumber: '1',
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailingNumber,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.orange),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
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
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
