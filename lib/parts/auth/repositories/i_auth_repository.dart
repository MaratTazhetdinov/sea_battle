part of '../auth_part.dart';

abstract class IAuthRepository {
  Stream<UserModel> get user;

  Future<void> signInByEmailAndPassword(
      {required String email, required String password});

  Future<String?> signUpByEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
}
