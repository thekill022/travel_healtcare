class Country {
  String? name;
  String? iso2;

  Country({
    this.name,
    this.iso2,
  });

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso2 = json['iso2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso2'] = this.iso2;
    return data;
  }
}
