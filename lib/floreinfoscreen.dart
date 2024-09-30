import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsBox extends StatefulWidget {
  final String estimateId; // Accept the estimate ID to fetch details

  const DetailsBox({super.key, required this.estimateId}); // Require estimate ID in the constructor

  @override
  _DetailsBoxState createState() => _DetailsBoxState();
}

class _DetailsBoxState extends State<DetailsBox> {
  late Future<Map<String, dynamic>> estimateDetails;

  // Fetch API data based on estimate ID
  Future<Map<String, dynamic>> fetchEstimateDetails() async {
    final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final estimateFlow = data['Customer_Estimate_Flow'];

      return estimateFlow.firstWhere((estimate) => estimate['estimate_id'] == widget.estimateId, orElse: () => {});
    } else {
      throw Exception('Failed to load details');
    }
  }

  @override
  void initState() {
    super.initState();
    estimateDetails = fetchEstimateDetails(); // Initialize fetching details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<Map<String, dynamic>>(
        future: estimateDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load details'));
          } else {
            final estimate = snapshot.data!;

            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Existing House Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Using the estimate data fetched from the API dynamically
                    _buildInfoRow('Old Floor No', estimate['old_floor_no'].toString()),
                    const SizedBox(height: 8.0),
                    _buildInfoRow('New Floor No', estimate['new_floor_no'].toString()),
                    const SizedBox(height: 8.0),
                    _buildInfoRow('Packing Service', estimate['packing_service'] ?? 'Not Available'),
                    const SizedBox(height: 8.0),
                    _buildInfoRow('Distance from Door to Truck', estimate['old_parking_distance'] ?? 'Unknown'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String leftText, String rightText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: const TextStyle(color: Colors.grey)),
        Text(rightText, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
