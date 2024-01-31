import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';
import 'package:travel_healthcare/model/user_model.dart';

final String baseUrl = "http://10.0.2.2:5000/api";
final String baseUrlProd = "http://18.141.237.4:5000/api";

class UserDataController {
  final bool isEdit;
  final String apiUrl = '$baseUrl/medicals';

  UserDataController({required this.isEdit});

  Future<UserModel> getCurrentUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/users/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> userDataJson =
            jsonDecode(response.body)['data'];
        final UserModel currentUser = UserModel.fromJson(userDataJson);
        return currentUser;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Gagal mengambil data user saat ini');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<UserDataModel>> getUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/medicals/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(response.body)['data'];

        List<UserDataModel> symptoms = dataResponse
            .map((symptom) => UserDataModel.fromJson(symptom))
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

  Future<void> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token'); // Remove the token from shared preferences

      // Perform any additional logout logic here

      print('Logout successful');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
