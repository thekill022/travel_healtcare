import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class SymptomController {
  final String apiUrl = '$baseUrl/symptoms/';

  List<SymptomModel> symptomList = []; // Initialize endemicityList
  List<SymptomModel> filteredSymptomList = [];
  Future<List<SymptomModel>> getSymptoms({String? filter}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      // Add filter parameter to the API URL
      String url = filter != null ? '$apiUrl?filter=$filter' : apiUrl;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(response.body)['data'];

        List<SymptomModel> symptoms = dataResponse
            .map((symptom) => SymptomModel.fromJson(symptom))
            .toList();

        return symptoms;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<SymptomModel>> filterSymptom(String query) async {
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

        List<SymptomModel> data = responseData
            .map((jsonObject) => SymptomModel.fromJson(jsonObject))
            .toList();

        // Filter the list based on the query
        List<SymptomModel> filteredData = data
            .where((symptom) =>
                symptom.symptomName.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return filteredData;
      } else {
        throw Exception('Failed to fetch symptom data: ${response.statusCode}');
      }
    } catch (error) {
      throw error;
    }
  }
}
