part of '../auth_part.dart';

abstract class IAuthRepoistory {
  Stream<UserModel> get user;

  Future<void> signInByEmailAndPassword(
      {required String email, required String password});

  Future<void> signUpByEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
}
