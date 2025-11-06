class ToppingsModel {
  int? id;
  String? name;
  String? image;

  ToppingsModel({this.id, this.name, this.image});

  ToppingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
