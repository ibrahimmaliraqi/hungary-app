class UserModel {
  String? code;
  String? message;
  Data? data;

  UserModel({this.code, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? token;
  String? name;
  String? email;
  String? image;
  String? address;
  String? visa;

  Data({
    this.token,
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    visa = json['Visa'];
  }
}
