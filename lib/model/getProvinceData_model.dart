class States {
  int? id;
  String? name;
  String? iso2;

  States({this.id, this.name, this.iso2});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
