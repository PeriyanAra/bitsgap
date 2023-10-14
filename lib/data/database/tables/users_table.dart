import 'package:bitsgap/data/constants.dart';
import 'package:bitsgap/data/database/database_constants.dart';

String createUsersTable() {
  return '''
    CREATE TABLE ${DatabaseConstants.users} (
      ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.username} TEXT UNIQUE NOT NULL,
      ${DatabaseConstants.email} TEXT UNIQUE NOT NULL,
      ${Constants.accessToken} TEXT UNIQUE NOT NULL,
      ${DatabaseConstants.password} TEXT NOT NULL
    )
  ''';
}
