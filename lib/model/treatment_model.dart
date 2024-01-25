class TreatmentModel {
  final int id;
  final int diseaseid;
  final String titletreat;
  final String desctreat;
  TreatmentModel({
    required this.id,
    required this.diseaseid,
    required this.titletreat,
    required this.desctreat,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'],
      diseaseid: json['disease_id'],
      titletreat: json['title'],
      desctreat: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disease_id': diseaseid,
      'title': titletreat,
      'description': desctreat,
    };
  }
}
