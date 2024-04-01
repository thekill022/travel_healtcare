import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/travelscore_model.dart';

class TravelScoreController {
  final String apiUrl = '$baseUrlProd/travelScore';

  Future<void> createTravelScore(TravelScoreModel travelScoreModel) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      print('Request Payload: ${jsonEncode(travelScoreModel.toJson())}');
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(travelScoreModel.toJson()),
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<TravelScoreModel>> getTravelScore() async {
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

        if (responseData is List<dynamic>) {
          List<TravelScoreModel> travscore = responseData
              .map((score) => TravelScoreModel.fromJson(score))
              .toList();

          return travscore;
        } else if (responseData is Map<String, dynamic>) {
          // If the response is a single object, create a list with a single element
          List<TravelScoreModel> travscore = [
            TravelScoreModel.fromJson(responseData)
          ];

          return travscore;
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
}
