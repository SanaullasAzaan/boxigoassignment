import 'package:flutter/material.dart';

class DetailsBox extends StatelessWidget {
  final String oldFloorNo; // Old floor number
  final String newFloorNo; // New floor number
  final String packingService; // Packing service status
  final String parkingDistance; // Distance from door to truck

  // Constructor accepts all necessary data
  const DetailsBox({
    super.key,
    required this.oldFloorNo,
    required this.newFloorNo,
    required this.packingService,
    required this.parkingDistance,
  });

  @override
  Widget build(BuildContext context) {
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
            _buildInfoRow('Old Floor No', oldFloorNo),
            const SizedBox(height: 8.0),
            _buildInfoRow('New Floor No', newFloorNo),
            const SizedBox(height: 8.0),
            _buildInfoRow('Packing Service', packingService),
            const SizedBox(height: 8.0),
            _buildInfoRow('Distance from Door to Truck', parkingDistance),
          ],
        ),
      ),
    );
  }

  // Helper method to build the rows of details
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
