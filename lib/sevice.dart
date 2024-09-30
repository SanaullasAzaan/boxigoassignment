// lib/services/estimate_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class EstimateService {
  final String apiUrl = 'http://test.api.boxigo.in/sample-data/';

  Future<List<dynamic>> fetchEstimates() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['Customer_Estimate_Flow'];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
