import 'package:bitsgap/data/database/tables/users_table.dart';

List<String> initialScripts() {
  return [
    createUsersTable(),
  ];
}
