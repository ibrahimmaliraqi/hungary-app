// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? address;
  String? visa;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      image: image,
      address: address,
      visa: visa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'address': address,
      'visa': visa,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      visa: map['visa'] != null ? map['visa'] as String : null,
    );
  }
}
