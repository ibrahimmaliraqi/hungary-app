import 'dart:convert';

import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences _prefs;
  static const String userKey = 'user';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // Int
  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Bool
  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Double
  static Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Remove
  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // Clear
  static Future<bool> clear() {
    return _prefs.clear();
  }

  static Future<bool> saveUser(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      image: user.image,
      address: user.address,
      visa: user.visa,
      createdAt: user.createdAt,
      phoneNumber: user.phoneNumber,
    );

    return await _prefs.setString(
      userKey,
      jsonEncode(model.toMap()),
    );
  }

  static UserEntity? getUser() {
    final data = _prefs.getString(userKey);

    if (data == null) {
      return null;
    }

    final model = UserModel.fromMap(
      jsonDecode(data) as Map<String, dynamic>,
    );

    return model.toEntity();
  }

  static Future<bool> removeUser() {
    return _prefs.remove(userKey);
  }

  // هل يوجد مستخدم؟
  static bool hasUser() {
    return _prefs.containsKey(userKey);
  }

  // Check key
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
