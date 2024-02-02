class TravelHistoryModel {
  var id;
  final String kotaTujuan;
  final String provinsiTujuan;
  final String formattgl;
  final String durasiTravel;
  final String tujuanTravel;
  TravelHistoryModel({
    this.id,
    required this.kotaTujuan,
    required this.provinsiTujuan,
    required this.formattgl,
    required this.durasiTravel,
    required this.tujuanTravel,
  });

  factory TravelHistoryModel.fromJson(Map<String, dynamic> json) {
    return TravelHistoryModel(
      id: json['id'],
      kotaTujuan: json['city'],
      provinsiTujuan: json['province'],
      formattgl: json['departured_at'],
      durasiTravel: json['duration'],
      tujuanTravel: json['travel_purpose'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': kotaTujuan,
      'province': provinsiTujuan,
      'departured_at': formattgl,
      'duration': durasiTravel,
      'travel_purpose': tujuanTravel,
    };
  }
}
