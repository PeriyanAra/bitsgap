import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/data/auth.dart';
import 'package:bitsgap/data/auth/auth_repositoy_impl.dart';
import 'package:bitsgap/data/database/database_creator.dart';
import 'package:bitsgap/domain/auth.dart';
import 'package:sqflite/sqflite.dart';

class DataDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    di
      ..registerSingleton<Database>(
        await DatabaseCreator.initDatabase(),
      )
      ..registerFactory(
        () => AuthLocalDataSource(
          database: di(),
          appKeyValueStorage: di(),
        ),
      )
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
          authLocalDataSource: di(),
        ),
      );
  }
}
