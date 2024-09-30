import 'package:flutter/material.dart';

class CustomItemDropdown extends StatefulWidget { // Changed class name
  const CustomItemDropdown({super.key});

  @override
  _CustomItemDropdownState createState() => _CustomItemDropdownState(); // Changed state class name
}

class _CustomItemDropdownState extends State<CustomItemDropdown> { // Changed state class name
  bool isDropdownOpen = false; // Track whether dropdown is open or closed

  final List<String> dropdownItems = [
    'Kitchen',
    'Dining Room',
    'Bathroom',
    'Office',
    'Garage',
    'Balcony',
    'Library', // Added new item
  ];

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
                  'Custom Items ', // Static title that doesn't change
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the start (left)
                      child: Text(
                        'Furniture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Title text color
                        ),
                      ),
                    ),
                  ),

                  // The list of rooms
                  ...dropdownItems.map((String value) {
                    if (value == 'Kitchen') {
                      return _buildCustomRow(
                        icon: Icons.kitchen, // Kitchen icon
                        title: 'Kitchen',
                        subtitle: 'Small | Modern',
                        trailingNumber: '1',
                      );
                    } else if (value == 'Dining Room') {
                      return _buildCustomRow(
                        icon: Icons.dining, // Dining icon
                        title: 'Dining Room',
                        subtitle: 'Wood | Classic',
                        trailingNumber: '2',
                      );
                    } else if (value == 'Bathroom') {
                      return _buildCustomRow(
                        icon: Icons.bathtub, // Bathroom icon
                        title: 'Bathroom',
                        subtitle: 'Tile | Modern',
                        trailingNumber: '3',
                      );
                    } else if (value == 'Office') {
                      return _buildCustomRow(
                        icon: Icons.work, // Office icon
                        title: 'Office',
                        subtitle: 'Spacious | Bright',
                        trailingNumber: '4',
                      );
                    } else if (value == 'Garage') {
                      return _buildCustomRow(
                        icon: Icons.garage, // Garage icon
                        title: 'Garage',
                        subtitle: 'Double | Large',
                        trailingNumber: '5',
                      );
                    } else if (value == 'Balcony') {
                      return _buildCustomRow(
                        icon: Icons.balcony, // Balcony icon
                        title: 'Balcony',
                        subtitle: 'Open | Cozy',
                        trailingNumber: '6',
                      );
                    } else if (value == 'Library') {
                      // New item added here
                      return _buildCustomRow(
                        icon: Icons.library_books, // Library icon
                        title: 'Library',
                        subtitle: 'Quiet | Cozy',
                        trailingNumber: '7',
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside each item
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align text to the start
                          children: [
                            Text(
                              value,
                              style: const TextStyle(
                                fontSize: 14, // Normal font size
                                fontWeight: FontWeight.normal, // Regular weight
                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      );
                    }
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
