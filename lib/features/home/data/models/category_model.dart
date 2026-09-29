import 'package:hungry_app/features/home/domain/entities/category_entity.dart';

class CategoryModel {
  int id;
  String name;
  CategoryModel({
    required this.id,
    required this.name,
  });
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
