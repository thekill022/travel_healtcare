class SymptomModel {
  final int id;
  final String symptomName;
  final String symptomChar;

  SymptomModel({
    required this.id,
    required this.symptomName,
    required this.symptomChar,
  });

  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(
      id: json['id'],
      symptomName: json['symptom_name'],
      symptomChar: json['symptom_char'],
    );
  }

  bool get isChecked => false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symptom_name': symptomName,
      'symptom_char': symptomChar,
    };
  }
}
