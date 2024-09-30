import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> estimate; // Assume estimate is passed to the widget

  const HomePage({Key? key, required this.estimate}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Container(
              width: 120, // Fixed width for the left column
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Moving On: ${widget.estimate['moving_on']}', // Access using widget
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // Add more widgets here as needed
                ],
              ),
            ),

            // Right Side Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Example ListTile
                    Card(
                      child: ListTile(
                        title: Text('Estimate ID: ${widget.estimate['estimate_id']}'), // Access using widget
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Moving From: ${widget.estimate['moving_from']}'), // Access using widget
                            Text('Moving To: ${widget.estimate['moving_to']}'), // Access using widget
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
