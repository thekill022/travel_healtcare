import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/model/travelhistory_model.dart';

class TravelHistoryController {
  final String apiUrl = 'http://10.0.2.2:5000/api/travels';

  Future<void> createTravelHistory(TravelHistoryModel travelHistory) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      print('Request Payload: ${jsonEncode(travelHistory.toJson())}');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(travelHistory.toJson()),
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

  Future<List<TravelHistoryModel>> getTravelHistory() async {
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

        List<TravelHistoryModel> symptoms = dataResponse
            .map((symptom) => TravelHistoryModel.fromJson(symptom))
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

  Future<void> updateTravelHistory(
      int id, TravelHistoryModel travelHistory) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      print('Request Payload: ${jsonEncode(travelHistory.toJson())}');
      final response = await http.put(
        Uri.parse('$apiUrl/$id'), // Adjust the URL based on your API
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(travelHistory.toJson()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Travel history updated successfully');
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to update travel history');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteTravelHistory(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.delete(
        Uri.parse('$apiUrl/$id'), // Adjust the URL based on your API
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Travel history deleted successfully');
      } else {
        print('Delete request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete travel history');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
