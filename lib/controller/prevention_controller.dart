import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/prevention_model.dart';

class PreventionController {
  final String apiUrl = '$baseUrlProd/preventions';
  Future<List<PreventionModel>> getPreventionByDiseaseId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(
            '$apiUrl/preventions'), // Use the correct endpoint to get prevention by disease ID
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body)['data'];

        if (responseData != null && responseData is List<dynamic>) {
          List<PreventionModel> prevention = responseData
              .map((prevention) => PreventionModel.fromJson(prevention))
              .toList();

          return prevention;
        } else {
          throw Exception(
              'Invalid or missing "data" attribute in the server response');
        }
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load prevention');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
