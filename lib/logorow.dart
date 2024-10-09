import 'package:flutter/material.dart';

class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space items evenly
        children: [
          // Left side with logo and text
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0), // Padding around the logo
                child: Image.asset(
                  'assets/images/logo1.png', 
                 height: 40, // Adjust height as needed
                ),
              ),
            const  Padding(
                padding:  EdgeInsets.all(8.0), // Padding around the text
                child: Text(
                  'Leads', // Replace with your app name
                  style: TextStyle(
                    color: Colors.grey, // Set text color to grey
                    fontSize: 18,
                    fontWeight: FontWeight.normal // Adjust font size as needed
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
