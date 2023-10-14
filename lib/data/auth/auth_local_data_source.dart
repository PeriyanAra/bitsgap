import 'package:bitsgap/data/auth/dto/user_info_dto.dart';
import 'package:bitsgap/data/constants.dart';
import 'package:bitsgap/data/database/database_constants.dart';
import 'package:bitsgap/domain/auth/entities/user_info.dart';
import 'package:bitsgap/domain/domain.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({
    required AppKeyValueStorage appKeyValueStorage,
    required Database database,
  })  : _database = database,
        _storage = appKeyValueStorage;

  final Database _database;
  final AppKeyValueStorage _storage;

  Future<bool> register(UserInfo user) async {
    try {
      final token = DateTime.now().toString();

      await _database.rawInsert(
        '''
      INSERT INTO ${DatabaseConstants.users}(
        ${DatabaseConstants.username},
        ${DatabaseConstants.email},
        ${Constants.accessToken},
        ${DatabaseConstants.password}
        ) VALUES(?, ?, ?, ?)''',
        [
          user.username,
          user.email?.toString(),
          token,
          user.password,
        ],
      );

      await _storage.write<String>(Constants.accessToken, token);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<UserInfoDto?> login(UserInfo user) async {
    final result = await _database.query(
      DatabaseConstants.users,
      where: '${DatabaseConstants.username} = ? AND ${DatabaseConstants.password} = ?',
      whereArgs: [user.username, user.password],
    );

    if (result.isNotEmpty) {
      await _storage.write<String>(
        Constants.accessToken,
        result.first[Constants.accessToken]! as String,
      );

      return UserInfoDto.fromJson(result.first);
    }

    return null;
  }

  Future<bool> logout() async {
    try {
      await _storage.remove(Constants.accessToken);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<UserInfoDto?> checkUserAuthenticatedInApp() async {
    try {
      final token = await _storage.read<String>(Constants.accessToken);

      if (token != null) {
        final result = await _database.query(
          DatabaseConstants.users,
          where: '${Constants.accessToken} = ?',
          whereArgs: [token],
        );

        if (result.isNotEmpty) {
          return UserInfoDto.fromJson(result.first);
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
