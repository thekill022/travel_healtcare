import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/diagnose_model.dart';
import 'package:travel_healthcare/model/posttravel_model.dart';

class PostTravelController {
  final String apiUrl = '$baseUrl/posttravel';

  Future<List<DiagnoseModel>> createTravelHistory(
      List<int> selectedSymptomIds) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final postTravelModel = PostTravelModel(symptom: selectedSymptomIds);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postTravelModel.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(response.body)['data'];

        List<DiagnoseModel> diagnoses = dataResponse
            .map((diagnose) => DiagnoseModel.fromJson(diagnose))
            .toList();

        for (DiagnoseModel diagnoseResult in diagnoses) {
          print(
              'Diagnose Result: ${diagnoseResult.diseaseName}, ${diagnoseResult.diseaseDesc}, ${diagnoseResult.percentage}%');
        }
        return diagnoses;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to create travel history');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<DiagnoseModel>> getDiagnose() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(response.body)['data'];

        List<DiagnoseModel> diagnoses = dataResponse
            .map((diagnose) => DiagnoseModel.fromJson(diagnose))
            .toList();

        return diagnoses;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
