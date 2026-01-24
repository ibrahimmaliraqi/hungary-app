class UserModel {
  String? uId;
  String? name;
  String? email;
  String? image;
  String? address;
  String? visa;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['token'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    visa = json['visa'];
  }
}
