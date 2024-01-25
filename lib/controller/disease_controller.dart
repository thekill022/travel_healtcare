import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_healthcare/controller/travelhistory_controller.dart';
import 'package:travel_healthcare/model/disease_model.dart';
import 'package:travel_healthcare/model/prevention_model.dart';
import 'package:travel_healthcare/model/treatment_model.dart';

class DiseaseController {
  final String apiUrl = '$baseUrl/diseases';
  Future<DiseaseModel> getDisease() async {
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

        if (jsonResponse.containsKey('data')) {
          final Map<String, dynamic> dataResponse = jsonResponse['data'];

          if (dataResponse.containsKey('Treatment') &&
              dataResponse['Treatment'] &&
              dataResponse.containsKey('Prevention') &&
              dataResponse['Prevention'] is List<dynamic>) {
            final List<dynamic> diseasedataTreatment =
                dataResponse['Treatment'];

            final List<dynamic> diseasedataPrevention =
                dataResponse['Prevention'];

            List<TreatmentModel> diseaseTreatment = diseasedataTreatment
                .map((treatData) => TreatmentModel.fromJson(treatData))
                .toList();

            List<PreventionModel> diseasePrevention = diseasedataPrevention
                .map((treatData) => PreventionModel.fromJson(treatData))
                .toList();

            DiseaseModel result = DiseaseModel(
              id: dataResponse['id'],
              diseaseName: dataResponse['disease_name'],
              diseaseDesc: dataResponse['disease_desc'],
              treatment: diseaseTreatment,
              prevention: diseasePrevention,
            );

            return result;
          } else {
            throw Exception(
                'Missing or invalid "DiseaseEndemic" attribute in the server response');
          }
        } else {
          throw Exception('Missing "data" attribute in the server response');
        }

        // List<DiseaseModel> disease = dataResponse
        //     .map((disease) => DiseaseModel.fromJson(disease))
        //     .toList();

        // return disease;
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
