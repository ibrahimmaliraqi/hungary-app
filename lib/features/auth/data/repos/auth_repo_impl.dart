import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/supabsae_failure.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';
import 'package:hungry_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, String>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final info = res.user;
      await saveUserData(name, email, info!.id);

      return right(info.id);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }

  @override
  Future saveUserData(
    String name,
    String email,
    String uId,
  ) async {
    await supabase.from('users').insert({
      'name': name,
      'email': email,
      "uid": uId,
    });
  }

  @override
  Future<Either<Failure, dynamic>> login(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final info = res.user;

      return right(info!.id);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getProfileData({
    required String uId,
  }) async {
    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('uid', uId)
          .single();

      final user = UserModel.fromJson(data);

      return right(user);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateProfileData({
    required String name,
    required String uId,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final avatarFile = File(imagePath!);
      await supabase.storage
          .from('profile')
          .upload(
            'profileImages/$uId.png',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      final String publicUrl = supabase.storage
          .from('profile')
          .getPublicUrl('profileImages/$uId.png');
      await supabase
          .from('users')
          .update({
            'name': name,
            'email': email,
            'address': address,
            'image': publicUrl,
            'visa': visa,
          })
          .eq('uid', uId);

      return right("تم تحديث البيانات بنجاح");
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }
}
