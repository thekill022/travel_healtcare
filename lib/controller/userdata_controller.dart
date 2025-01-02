import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/UserDataModel.dart';
import 'package:travel_healthcare/model/user_model.dart';

class UserDataController {
  final bool isEdit;
  final String apiUrl = '$baseUrlProd/medicals';

  UserDataController({required this.isEdit});

  Future<UserModel> getCurrentUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrlProd/users/'),
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
        Uri.parse('$baseUrlProd/medical'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body)['data'];

        if (responseData is List<dynamic>) {
          List<UserDataModel> userdata =
              responseData.map((user) => UserDataModel.fromJson(user)).toList();

          return userdata;
        } else if (responseData is Map<String, dynamic>) {
          // If the response is a single object, create a list with a single element
          List<UserDataModel> userdata = [UserDataModel.fromJson(responseData)];

          return userdata;
        } else {
          throw Exception('Invalid response format');
        }
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

  Future<int?> getUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrlProd/users/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userDataJson =
            jsonDecode(response.body)['data'];
        final UserModel currentUser = UserModel.fromJson(userDataJson);
        return currentUser.id;
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to get user ID');
      }
    } catch (e) {
      print('Error getting user ID: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      // Sesuaikan dengan endpoint yang benar
      final response = await http.delete(
        Uri.parse('$baseUrlProd/users'), // Hapus /api dari URL
        headers: {
          'Authorization': 'Bearer $token', // Bearer token wajib sesuai API
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Parse response body
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        // Jika berhasil, hapus token
        await prefs.remove('token');
        print('User deleted successfully: ${responseData['message']}');
      } else {
        // Ambil pesan error dari response API
        final errorMessage = responseData['message'] ?? 'Failed to delete user';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error deleting user: $e');
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
