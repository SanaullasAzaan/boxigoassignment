import 'package:flutter/material.dart';

class ItemsNavBar extends StatefulWidget {
  final Function(String) onItemSelected; // Callback to notify the parent

  const ItemsNavBar({super.key, required this.onItemSelected}); // Accept the callback in constructor

  @override
  _ItemsNavBarState createState() => _ItemsNavBarState();
}

class _ItemsNavBarState extends State<ItemsNavBar> {
  String selectedItem = 'items'; // Default selected item

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavBarItem('items'),
          _buildNavBarItem('Floor Info'),
          _buildNavBarItem('Send Quote'),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(String title) {
    final isSelected = selectedItem == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedItem = title;
          });
          widget.onItemSelected(title); // Notify the parent about the selection
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.orange : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
