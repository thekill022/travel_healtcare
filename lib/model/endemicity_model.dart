class EndemicityModel {
  final int id;
  final String diseaseEndemic;
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
      diseaseEndemic: json['DiseaseEndemic'] ?? '',
      countryname: json['country_name'] ?? '',
      risklevel: json['risk_level'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DiseaseEndemic': diseaseEndemic,
      'country_name': countryname,
      'risk_level': risklevel
    };
  }
}
