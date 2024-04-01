import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';
import 'package:travel_healthcare/model/getpretravel_model.dart';

class GetPreTravelController {
  final String apiUrl = '$baseUrlProd/pretravel';

  Future<GetPreTravelModel> getDiseaseEndemic(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Bearer token not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final Map<String, dynamic> dataResponse = jsonResponse['data'];

          if (dataResponse.containsKey('DiseaseEndemic') &&
              dataResponse['DiseaseEndemic'] is List<dynamic>) {
            final List<dynamic> diseaseDataList =
                dataResponse['DiseaseEndemic'];

            List<DiseaseModel> diseaseList = diseaseDataList
                .map((diseaseData) => DiseaseModel.fromJson(diseaseData))
                .toList();

            GetPreTravelModel result = GetPreTravelModel(
              id: dataResponse['id'],
              diseaseEndemic: diseaseList,
              countryName: dataResponse['country_name'],
              riskLevel: dataResponse['risk_level'],
            );

            return result;
          } else {
            throw Exception(
                'Missing or invalid "DiseaseEndemic" attribute in the server response');
          }
        } else {
          throw Exception('Missing "data" attribute in the server response');
        }
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to load diseases');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
