import 'dart:convert';

class SymptomModel {
  final String symptomName;
  final String symptomChar;
  var id;

  SymptomModel({
    required this.symptomName,
    required this.symptomChar,
    required this.id,
  });

  SymptomModel copyWith({
    String? symptomName,
    String? symptomChar,
    int? id,
  }) {
    return SymptomModel(
      symptomName: symptomName ?? this.symptomName,
      symptomChar: symptomChar ?? this.symptomChar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symptom_name': symptomName,
      'symptom_char': symptomChar,
      'id': id.toMap(),
    };
  }

  factory SymptomModel.fromMap(Map<String, dynamic> map) {
    return SymptomModel(
      symptomName: map['symptom_name'] ?? '',
      symptomChar: map['symptom_char'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SymptomModel.fromJson(String source) =>
      SymptomModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SymptomModel(symptomName: $symptomName, symptomChar: $symptomChar, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SymptomModel &&
        other.symptomName == symptomName &&
        other.symptomChar == symptomChar &&
        other.id == id;
  }

  @override
  int get hashCode => symptomName.hashCode ^ symptomChar.hashCode ^ id.hashCode;
}
