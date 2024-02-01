class PostTravelModel {
  final List<int>? symptom;

  PostTravelModel({
    this.symptom,
  });

  factory PostTravelModel.fromJson(Map<String, dynamic> json) {
    return PostTravelModel(
      symptom: json['symptoms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptom,
    };
  }
}
