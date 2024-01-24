import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/endemicity_model.dart';

class EndemicityController {
  final String apiUrl = '$baseUrl/endemics';

  List<EndemicityModel> endemicityList = []; // Initialize endemicityList
  List<EndemicityModel> filteredEndemicityList = [];
  Future<List<EndemicityModel>> getEndemicity() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(response.body)['data'];

        List<EndemicityModel> endemicity = dataResponse
            .map((endemicity) => EndemicityModel.fromJson(endemicity))
            .toList();

        return endemicity;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<EndemicityModel>> filterEndemicity(String query) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body)['data'];

        List<EndemicityModel> data = responseData
            .map((jsonObject) => EndemicityModel.fromJson(jsonObject))
            .toList();

        // Filter the list based on the query
        List<EndemicityModel> filteredData = data
            .where((endemicity) => endemicity.countryname
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        return filteredData;
      } else {
        throw Exception(
            'Failed to fetch endemicity data: ${response.statusCode}');
      }
    } catch (error) {
      throw error;
    }
  }
}
