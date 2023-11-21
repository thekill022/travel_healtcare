import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class SymptomController {
  final String apiUrl = 'http://10.0.2.2:5000/api/symptoms/';
  Future<List<SymptomModel>> getSymptoms() async {
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
}
