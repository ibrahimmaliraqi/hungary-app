import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(String email, String password);
}
