import 'package:bitsgap/domain/auth/entities.dart';

abstract class AuthRepository {
  Future<bool> register(UserInfo user);

  Future<UserInfo?> login(UserInfo user);

  Future<UserInfo?> checkUserAuthenticatedInApp();

  Future<bool> logout();
}
