import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:boxigoapp/viewdetailslayout.dart';

class ResponsiveBoxWithColumn extends StatefulWidget {
  const ResponsiveBoxWithColumn({Key? key}) : super(key: key);

  @override
  _ResponsiveBoxWithColumnState createState() =>
      _ResponsiveBoxWithColumnState();
}

class _ResponsiveBoxWithColumnState extends State<ResponsiveBoxWithColumn> {
  // Fetch API data
  Future<List<dynamic>> fetchApiData() async {
    final response =
        await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['Customer_Estimate_Flow']; // Return list of estimates
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<dynamic>>(
        future: fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load data'));
          } else {
            final estimates = snapshot.data;

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: estimates?.length ?? 0,
              itemBuilder: (context, index) {
                final customerEstimate = estimates![index];
                final movingFrom = customerEstimate['moving_from'];
                final movingTo = customerEstimate['moving_to'];
                final estimateId = customerEstimate['estimate_id'];

                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Left Column inside the Card with a defined width
                                Container(
                                  width: 80,
                                  height: 400,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'AUG',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        '${customerEstimate['moving_on']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Expanded content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Horizontal container with image instead of arrow icon
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 1.0),
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                child: Image.asset(
                                                  'assets/images/arrow_down.png', // Replace with the path to your image
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Column(
                                                children: [
                                                  const Icon(Icons.home,
                                                      color: Colors.orange),
                                                  Text(
                                                      '${customerEstimate['property_size']}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(width: 14),
                                              const Column(
                                                children: [
                                                  Icon(Icons.list,
                                                      color: Colors.orange),
                                                  Text('Items',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(width: 14),
                                              const Column(
                                                children: [
                                                  Icon(Icons.check_box,
                                                      color: Colors.orange),
                                                  Text('Boxes',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(width: 14),
                                              Column(
                                                children: [
                                                  const Icon(Icons.travel_explore,
                                                      color: Colors.orange),
                                                  Text('${customerEstimate['distance']}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16), // Spacing between icons and text

                                      Text(
                                        '$movingFrom',
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '$movingTo',
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 16),

                                      // Row for buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DetailsLayout()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.orange),
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.orange,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 24),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child: const Text('View Details',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DetailsLayout()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.orange),
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.orange,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 24),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child: const Text('Submit Quote',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bangalore',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF5722),
                                  ),
                                ),
                                const SizedBox(width: 150),
                                Text(
                                  '$estimateId',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
