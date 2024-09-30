import 'package:flutter/material.dart';
import 'package:boxigoapp/mainlayout.dart'; // Import your MainLayout here

class ResponsiveRowone extends StatelessWidget {
  const ResponsiveRowone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space items evenly
        children: [
          // Left side with back arrow icon and text
          Row(
            children: [
              // Back arrow icon
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()), // Navigate to MainLayout
                  );
                },
                icon: const Icon(Icons.arrow_back_ios_outlined),
                color: Colors.grey, // Set icon color to grey
              ),
              // Text with increased font size and boldness
              const Padding(
                padding: EdgeInsets.all(8.0), // Padding around the text
                child: Text(
                  'New Leads', // Text
                  style: TextStyle(
                    color: Colors.grey, // Set text color to grey
                    fontSize: 24, // Increase font size
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ),
              const SizedBox(width: 40), // Increased space between text and icons
            ],
          ),
          // Right side with icons
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // Padding for notification icon
                child: IconButton(
                  onPressed: () {
                    // Add notification action here
                  },
                  icon: const Icon(Icons.notifications_active_rounded),
                  color: Colors.grey, // Set color to grey
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // Padding for search icon
                child: IconButton(
                  onPressed: () {
                    // Add search action here
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.grey, // Set color to grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
