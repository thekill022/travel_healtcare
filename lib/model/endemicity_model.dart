import 'package:travel_healthcare/model/disease_model.dart';

class EndemicityModel {
  final int id;
  final List<DiseaseModel> diseaseEndemic;
  final String countryname;
  final String risklevel;
  EndemicityModel({
    required this.id,
    required this.diseaseEndemic,
    required this.countryname,
    required this.risklevel,
  });

  factory EndemicityModel.fromJson(Map<String, dynamic> json) {
    return EndemicityModel(
      id: json['id'],
      diseaseEndemic: (json['DiseaseEndemic'] as List<dynamic>)
          .map((diseaseData) => DiseaseModel.fromJson(diseaseData))
          .toList(),
      countryname: json['country_name'] ?? '',
      risklevel: json['risk_level'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DiseaseEndemic':
          diseaseEndemic.map((diseaseModel) => diseaseModel.toJson()).toList(),
      'country_name': countryname,
      'risk_level': risklevel
    };
  }
}
