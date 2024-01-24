class DiseaseModel {
  final int id;
  final String diseaseName;
  final String diseaseDesc;
  final List<dynamic>? diseaseSymptom;
  final List<dynamic> treatment;
  final List<dynamic> prevention;

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
      treatment: json['Treatment'] ?? [],
      prevention: json['Prevention'] ?? [],
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
