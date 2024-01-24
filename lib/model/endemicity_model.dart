class EndemicityModel {
  final int id;
  final String diseaseEndemic;
  final String countryname;
  EndemicityModel({
    required this.id,
    required this.diseaseEndemic,
    required this.countryname,
  });

  factory EndemicityModel.fromJson(Map<String, dynamic> json) {
    return EndemicityModel(
      id: json['id'],
      diseaseEndemic: json['DiseaseEndemic'],
      countryname: json['country_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DiseaseEndemic': diseaseEndemic,
      'country_name': countryname,
    };
  }
}
