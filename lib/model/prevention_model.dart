class PreventionModel {
  final int id;
  final int diseaseid;
  final String titleprev;
  final String descprev;
  PreventionModel({
    required this.id,
    required this.diseaseid,
    required this.titleprev,
    required this.descprev,
  });

  factory PreventionModel.fromJson(Map<String, dynamic> json) {
    return PreventionModel(
      id: json['id'],
      diseaseid: json['disease_id'] ?? 0,
      titleprev: json['title'] ?? '',
      descprev: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disease_id': diseaseid,
      'title': titleprev,
      'description': descprev,
    };
  }
}
