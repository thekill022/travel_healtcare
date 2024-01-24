import 'package:travel_healthcare/model/disease_model.dart';

class GetPreTravelModel {
  final int id;
  final List<DiseaseModel> diseaseEndemic;
  final String countryName;
  final String riskLevel;

  GetPreTravelModel({
    required this.id,
    required this.diseaseEndemic,
    required this.countryName,
    required this.riskLevel,
  });

  factory GetPreTravelModel.fromJson(Map<String, dynamic> json) {
    return GetPreTravelModel(
      id: json['id'],
      diseaseEndemic: (json['DiseaseEndemic'] as List<dynamic>)
          .map((diseaseData) => DiseaseModel.fromJson(diseaseData))
          .toList(),
      countryName: json['country_name'],
      riskLevel: json['risk_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DiseaseEndemic':
          diseaseEndemic.map((diseaseModel) => diseaseModel.toJson()).toList(),
      'country_name': countryName,
      'risk_level': riskLevel,
    };
  }
}
