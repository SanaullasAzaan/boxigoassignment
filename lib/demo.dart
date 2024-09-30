import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to fetch data from the API
Future<void> fetchFurnitureData() async {
  final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/')); // Replace with your actual API URL

  if (response.statusCode == 200) {
    // Decode the JSON response
    final data = json.decode(response.body);

    // Accessing the inventory
    final category = data['category']; // Access the category list
    if (category.isNotEmpty) {
      final firstCategory = category[0]; // Get the first category (sofa in this case)
      final items = firstCategory['items']; // Access items in the category

      if (items.isNotEmpty) {
        final firstItem = items[0]; // Get the first item (sofa_1_seater_sofa)
        
        // Accessing desired fields
        final typeOptions = firstItem['typeOptions']; // Access type options
        final quantity = firstItem['qty']; // Access quantity
        final displayName = firstItem['displayName']; // Access display name

        // Print the values to console
        print('Type Options: $typeOptions'); // Prints: "Type Options: Leather, Fabric, Wooden, Cane, Recliner"
        print('Quantity: $quantity'); // Prints: "Quantity: 2"
        print('Display Name: $displayName'); // Prints: "Display Name: 1 Seater Sofa"
      }
    }
  } else {
    throw Exception('Failed to load data');
  }
}
