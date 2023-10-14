import 'package:bitsgap/data/auth.dart';
import 'package:bitsgap/domain/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
  }) : _localDataSource = authLocalDataSource;

  final AuthLocalDataSource _localDataSource;

  @override
  Future<UserInfo?> login(UserInfo user) async {
    final userInfoDto = await _localDataSource.login(user);

    if (userInfoDto != null) {
      return userInfoDto.toEntity();
    }

    return null;
  }

  @override
  Future<bool> register(UserInfo user) {
    return _localDataSource.register(user);
  }

  @override
  Future<UserInfo?> checkUserAuthenticatedInApp() async {
    final userInfoDto = await _localDataSource.checkUserAuthenticatedInApp();

    return userInfoDto?.toEntity();
  }

  @override
  Future<bool> logout() {
    return _localDataSource.logout();
  }
}
