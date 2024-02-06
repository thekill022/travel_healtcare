class DiagnoseModel {
  final int diseaseId;
  final String diseaseName;
  final String diseaseDesc;
  final int percentage;
  DiagnoseModel({
    required this.diseaseId,
    required this.diseaseName,
    required this.diseaseDesc,
    required this.percentage,
  });

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) {
    return DiagnoseModel(
      diseaseId: json['disease_id'] ?? '',
      diseaseName: json['disease_name'] ?? '',
      diseaseDesc: json['disease_desc'] ?? '',
      percentage: json['percentage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_id': diseaseId,
      'disease_name': diseaseName,
      'disease_desc': diseaseDesc,
      'percentage': percentage
    };
  }
}
