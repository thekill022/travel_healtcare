class TravelScoreModel {
  final int provinsiTujuanBobot;
  final int durasiTravelBobot;
  final int tujuanTavelBobot;
  final String categories;

  TravelScoreModel(
      {required this.provinsiTujuanBobot,
      required this.durasiTravelBobot,
      required this.tujuanTavelBobot,
      required this.categories});

  factory TravelScoreModel.fromJson(Map<String, dynamic> json) {
    return TravelScoreModel(
      provinsiTujuanBobot: json['destination_score'] ?? '',
      durasiTravelBobot: json['duration'] ?? '',
      tujuanTavelBobot: json['travel_purpose'] ?? '',
      categories: json['categories'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination_score': provinsiTujuanBobot,
      'duration': durasiTravelBobot,
      'travel_purpose': tujuanTavelBobot,
      'categories': categories
    };
  }
}
