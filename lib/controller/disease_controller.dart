import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';

class DiseaseController {
  final String apiUrl = '$baseUrlProd/diseases';
  Future<List<DiseaseModel>> getDisease() async {
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
        final dynamic responseData = json.decode(response.body)['data'];

        if (responseData != null && responseData is List<dynamic>) {
          List<DiseaseModel> diseases = responseData
              .map((disease) => DiseaseModel.fromJson(disease))
              .toList();
          return diseases;
        } else {
          throw Exception(
              'Invalid or missing "data" attribute in the server response');
        }
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load diseases');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
