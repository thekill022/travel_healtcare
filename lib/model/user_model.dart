class UserModel {
  var id;
  final String nama;
  final String email;
  UserModel({
    this.id,
    required this.nama,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': nama,
      'email': email,
    };
  }
}
