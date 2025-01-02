class TravelHistoryModel {
  var id;
  final String negaraTujuan;
  final String kotaTujuan;
  final String provinsiTujuan;
  final String formattgl;
  final String durasiTravel;
  final String tujuanTravel;
  TravelHistoryModel({
    this.id,
    required this.negaraTujuan,
    required this.kotaTujuan,
    required this.provinsiTujuan,
    required this.formattgl,
    required this.durasiTravel,
    required this.tujuanTravel,
  });

  factory TravelHistoryModel.fromJson(Map<String, dynamic> json) {
    return TravelHistoryModel(
      id: json['id'],
      negaraTujuan: json['country'],
      provinsiTujuan: json['province'],
      kotaTujuan: json['city'],
      formattgl: json['departured_at'],
      durasiTravel: json['duration'],
      tujuanTravel: json['travel_purpose'],
    );
  }

  get userId => null;

  get provinsiTujuanbobot => null;

  get durasiTravelbobot => null;

  get tujuanTravelbobot => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': negaraTujuan,
      'province': provinsiTujuan,
      'city': kotaTujuan,
      'departured_at': formattgl,
      'duration': durasiTravel,
      'travel_purpose': tujuanTravel,
    };
  }
}
