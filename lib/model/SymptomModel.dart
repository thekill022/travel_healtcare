import 'dart:convert';

class SymptomModel {
  var id;
  final String symptomName;
  final String symptomChar;
  SymptomModel({
    this.id,
    required this.symptomName,
    required this.symptomChar,
  });

  // SymptomModel copyWith({
  //   int? id,
  //   String? symptomName,
  //   String? symptomChar,
  // }) {
  //   return SymptomModel(
  //     id: id ?? this.id,
  //     symptomName: symptomName ?? this.symptomName,
  //     symptomChar: symptomChar ?? this.symptomChar,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symptom_name': symptomName,
      'symptom_char': symptomChar,
    };
  }

  factory SymptomModel.fromMap(Map<String, dynamic> map) {
    return SymptomModel(
      id: map['id'],
      symptomName: map['symptom_name'] ?? '',
      symptomChar: map['symptom_char'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SymptomModel.fromJson(String source) =>
      SymptomModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SymptomModel &&
        other.id == id &&
        other.symptomName == symptomName &&
        other.symptomChar == symptomChar;
  }

  @override
  int get hashCode => id.hashCode ^ symptomName.hashCode ^ symptomChar.hashCode;
}
