class DiseaseModel {
  final int id;
  final String diseaseName;
  final String diseaseDesc;
  final List<dynamic>?
      diseaseSymptom; // You might want to replace 'dynamic' with the actual type if you have a specific structure for DiseaseSymptom
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
        treatment: json['Treatment'],
        prevention: json['Prevention']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disease_name': diseaseName,
      'disease_desc': diseaseDesc,
      'Treatment': treatment,
      'Prevention': prevention,
    };
  }
}
