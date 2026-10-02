// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? address;
  String? visa;
  String? phoneNumber;
  String? createdAt;
  UserModel({
    this.phoneNumber,
    this.createdAt,
    this.id,
    this.name,
    this.email,
    this.image,
    this.address,
    this.visa,
  });
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      image: entity.image,
      address: entity.address,
      visa: entity.visa,
      phoneNumber: entity.phoneNumber,
      createdAt: entity.createdAt,
    );
  }
  UserEntity toEntity() {
    return UserEntity(
      createdAt: createdAt,
      phoneNumber: phoneNumber,
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
      'phone_number': phoneNumber,
      'image': image,
      "created_at": createdAt,
      'address': address,
      'visa': visa,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phone_number'] != null
          ? map['phone_number'] as String
          : null,

      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      visa: map['visa'] != null ? map['visa'] as String : null,
    );
  }
}
