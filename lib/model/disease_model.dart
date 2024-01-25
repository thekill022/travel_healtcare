import 'package:travel_healthcare/model/prevention_model.dart';
import 'package:travel_healthcare/model/treatment_model.dart';

class DiseaseModel {
  final int id;
  final String diseaseName;
  final String diseaseDesc;
  final List<dynamic>? diseaseSymptom;
  final List<TreatmentModel> treatment;
  final List<PreventionModel> prevention;

  DiseaseModel({
    required this.id,
    required this.diseaseName,
    required this.diseaseDesc,
    this.diseaseSymptom,
    required this.treatment,
    required this.prevention,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      diseaseName: json['disease_name'],
      diseaseDesc: json['disease_desc'],
      diseaseSymptom: json['DiseaseSymptom'],
      treatment: (json['Treatment'] as List<dynamic>)
          .map((treatData) => TreatmentModel.fromJson(treatData))
          .toList(),
      prevention: (json['Prevention'] as List<dynamic>)
          .map((prevData) => PreventionModel.fromJson(prevData))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disease_name': diseaseName,
      'disease_desc': diseaseDesc,
      'DiseaseSymptom': diseaseSymptom,
      'Treatment': treatment,
      'Prevention': prevention,
    };
  }
}
