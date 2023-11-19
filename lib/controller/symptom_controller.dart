import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/SymptomModel.dart';

class SymptomController {
  final String apiUrl = 'http://10.0.2.2:5000/api/symptoms/';

  Future<List<SymptomModel>> fetchSymptoms() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        // If the token is not found, you might want to handle this case differently.
        // For example, navigate the user to the login screen or perform authentication.
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<SymptomModel> symptoms = [];
        for (var i in data) {
          SymptomModel symptom = SymptomModel.fromMap(i);
          symptoms.add(symptom);
        }
        // List<SymptomModel> symptoms =
        //     data.map((item) => SymptomModel.fromJson(item)).toList();
        return symptoms;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
