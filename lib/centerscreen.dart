import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxigoapp/viewdetailslayout.dart';

class ResponsiveBoxWithColumn extends StatefulWidget {
  const ResponsiveBoxWithColumn({Key? key}) : super(key: key);

  @override
  _ResponsiveBoxWithColumnState createState() =>
      _ResponsiveBoxWithColumnState();
}

class _ResponsiveBoxWithColumnState extends State<ResponsiveBoxWithColumn> {
  Future<List<dynamic>> fetchApiData() async {
    final response =
        await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['Customer_Estimate_Flow'];
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
                    Container(
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0), 
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 400,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'AUG',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                           color: Color(0xFFFF5722),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // "Moving From" field
                                      Container(
                                       // color: Colors.yellow,
                                        height: 50,
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                            top: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '$movingFrom',
                                                style: const TextStyle (
                                                  fontSize: 16,
                                                 
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      // Horizontal container with image
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 1.0),
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: Image.asset(
                                                  'assets/images/arrow.png',
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              const SizedBox(width: 0),
                                              Column(
                                                children: [
                                                  const Icon(Icons.home,
                                                      color: Colors.orange),
                                                  Text(
                                                    '${customerEstimate['property_size']}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 26),
                                              const Column(
                                                children: [
                                                  Icon(Icons.list,
                                                      color: Colors.orange),
                                                  Text('Items',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(width: 26),
                                              const Column(
                                                children: [
                                                  Icon(Icons.check_box,
                                                      color: Colors.orange),
                                                  Text('Boxes',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(width: 26),
                                              Column(
                                                children: [
                                                  const Icon(
                                                      Icons.travel_explore,
                                                      color: Colors.orange),
                                                  Text(
                                                    '${customerEstimate['distance']}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // New Row for "Bangalore"
                                   const   Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bangalore',
                                            style:  TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black, // Black bold text color
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      // "Moving To" field
                                      Container(
                                       // color: Colors.,
                                        height: 50,
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                            top: 0.0),
                                        child: Text(
                                          '$movingTo',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      // Row for buttons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DetailsLayout(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.orange),
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.orange,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 24),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child: const Text('View Details',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.orange),
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.orange,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 24),
                                              shape:
                                                  const RoundedRectangleBorder(
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
                            right: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bangalore',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                      thickness: 2,
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
