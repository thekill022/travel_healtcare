class TravelScoreModel {
  final int durasiTravelBobot;
  final int tujuanTavelBobot;
  final String categories;

  TravelScoreModel(
      {required this.durasiTravelBobot,
      required this.tujuanTavelBobot,
      required this.categories});

  factory TravelScoreModel.fromJson(Map<String, dynamic> json) {
    return TravelScoreModel(
      durasiTravelBobot: json['duration'] ?? '',
      tujuanTavelBobot: json['travel_purpose'] ?? '',
      categories: json['categories'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': durasiTravelBobot,
      'travel_purpose': tujuanTavelBobot,
      'categories': categories
    };
  }
}
