import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';

final String baseUrl = "http://10.0.2.2:5000/api";
final String baseUrlProd = "http://18.141.237.4:5000/api";

class UserDataController {
  final bool isEdit;
  final String apiUrl = '$baseUrl/medicals';

  UserDataController({required this.isEdit});

  Future<void> createUserData(UserDataModel userData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      print('Request Payload: ${jsonEncode(userData.toJson())}');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData.toJson()),
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        print('Travel history created successfully');
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to create travel history');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> updateUserData(int id, UserDataModel userData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      print('Request Payload: ${jsonEncode(userData.toJson())}');
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData.toJson()),
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        print('Travel history created successfully');
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to create travel history');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
