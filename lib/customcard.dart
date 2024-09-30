import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return const  Material(
      color: Colors.white, // Set background color to white
      elevation: 0.0, // Remove shadow effect
      child: Padding(
        padding:  EdgeInsets.all(16.0), // Padding around the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
             Text(
              'Antique Clock', // Main heading
              style: TextStyle(
                fontSize: 20, // Font size for heading
                color: Colors.grey, // Grey color for heading
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
             SizedBox(height: 8.0), // Space between heading and subtext
             Text(
              'This is an exquisite antique clock that adds charm to any room. It features intricate details and craftsmanship.',
              style: TextStyle(
                fontSize: 14, // Smaller font size for subtext
                color: Colors.grey, // Light grey color for subtext
              ),
              maxLines: 2, // Limit the number of lines
              overflow: TextOverflow.ellipsis, // Handle overflow
            ),
             SizedBox(height: 16.0), // Space between subtext and dimensions
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text('L: 6ft', style: TextStyle(fontSize: 14)),
                SizedBox(width: 16.0), // Space between dimension texts
                Text('W: 6ft', style: TextStyle(fontSize: 14)),
                SizedBox(width: 16.0), // Space between dimension texts
                Text('H: 6ft', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
