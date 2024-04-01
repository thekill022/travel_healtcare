import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';
import 'package:travel_healthcare/model/endemicity_model.dart';

class EndemicityController {
  final String apiUrl = '$baseUrlProd/endemics';

  List<EndemicityModel> endemicityList = []; // Initialize endemicityList
  List<EndemicityModel> filteredEndemicityList = [];
  Future<EndemicityModel> getEndemicity() async {
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
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final Map<String, dynamic> dataResponse = jsonResponse['data'];

        if (dataResponse.containsKey('DiseaseEndemic') &&
            dataResponse['DiseaseEndemic'] is List<dynamic>) {
          final List<dynamic> diseaseDataList = dataResponse['DiseaseEndemic'];

          List<DiseaseModel> diseaseList = diseaseDataList
              .map((diseaseData) => DiseaseModel.fromJson(diseaseData))
              .toList();

          EndemicityModel result = EndemicityModel(
            id: dataResponse['id'],
            diseaseEndemic: diseaseList,
            countryname: dataResponse['country_name'],
            risklevel: dataResponse['risk_level'],
          );

          return result;
        } else {
          throw Exception(
              'Missing or invalid "DiseaseEndemic" attribute in the server response');
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

  Future<List<EndemicityModel>> filterEndemicity(String query) async {
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
        List<dynamic> responseData = json.decode(response.body)['data'];

        List<EndemicityModel> data = responseData
            .map((jsonObject) => EndemicityModel.fromJson(jsonObject))
            .toList();

        // Filter the list based on the query
        List<EndemicityModel> filteredData = data
            .where((endemicity) => endemicity.countryname
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        return filteredData;
      } else {
        throw Exception(
            'Failed to fetch endemicity data: ${response.statusCode}');
      }
    } catch (error) {
      throw error;
    }
  }
}
