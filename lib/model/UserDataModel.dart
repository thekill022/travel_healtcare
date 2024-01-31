class UserDataModel {
  var id;
  // final int userId;
  final String umur;
  final String kondisiMedis;
  final String pengobatan;
  final String alergi;
  final String reaksiVaksin;
  final String hamilMenyusui;
  bool vaccineBcg;
  bool vaccineHepatitis;
  bool vaccineDengue;

  UserDataModel({
    this.id,
    // required this.userId,
    required this.umur,
    required this.kondisiMedis,
    required this.pengobatan,
    required this.alergi,
    required this.reaksiVaksin,
    required this.hamilMenyusui,
    bool? vaccineBcg, // Ubah menjadi bool? untuk membuatnya opsional
    bool? vaccineHepatitis,
    bool? vaccineDengue,
  })  : vaccineBcg = vaccineBcg ?? false, // Tentukan nilai default di sini
        vaccineHepatitis = vaccineHepatitis ?? false,
        vaccineDengue = vaccineDengue ?? false;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? '',
      // userId: json['user_id'],
      umur: json['age'] ?? '',
      kondisiMedis: json['preexisting_condition'] ?? '',
      pengobatan: json['current_medication'] ?? '',
      alergi: json['allergies'] ?? '',
      reaksiVaksin: json['previous_vaccination'] ?? '',
      hamilMenyusui: json['pregnant'] ?? '',
      vaccineBcg: json['vaccine_bcg'],
      vaccineHepatitis: json['vaccine_hepatitis'],
      vaccineDengue: json['vaccine_dengue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'user_id': userId,
      'age': umur,
      'preexisting_condition': kondisiMedis,
      'current_medication': pengobatan,
      'allergies': alergi,
      'previous_vaccination': reaksiVaksin,
      'pregnant': hamilMenyusui,
      'vaccine_bcg': vaccineBcg,
      'vaccine_hepatitis': vaccineHepatitis,
      'vaccine_dengue': vaccineDengue,
    };
  }
}
