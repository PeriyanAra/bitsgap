import 'dart:developer';
import 'dart:io';

import 'package:bitsgap/data/database/initial_scripts.dart';
import 'package:bitsgap/data/database/migrations_scripts.dart';
import 'package:loggy/loggy.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseCreator {
  static Future<Database> initDatabase() async {
    log('Initializing database...');

    final bitsgapDbPath = await getDatabasePath(dbName: 'bitsgap_db');
    final version = migrationsScripts().length + 1;

    final database = await openDatabase(
      '$bitsgapDbPath/db.db',
      version: version,
      onUpgrade: executeMigration,
      onCreate: executeInitialization,
    );

    log('bitsgapDbPath --- $bitsgapDbPath');

    return database;
  }

  static Future<String> getDatabasePath({required String dbName}) async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$dbName';
    final dbExists = Directory(path).existsSync();

    if (!dbExists) {
      await Directory(path).create(recursive: true);
    }

    return path;
  }

  static Future<void> executeInitialization(
    Database db,
    int version,
  ) async {
    initialScripts().forEach(
      (script) async {
        try {
          await db.execute(script);
        } catch (error) {
          logError(error);
        }
      },
    );

    migrationsScripts().forEach(
      (script) async {
        try {
          await db.execute(script);
        } catch (error) {
          logError(error);
        }
      },
    );
  }

  static Future<void> executeMigration(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < newVersion) {
      final migrationScripts = migrationsScripts();

      for (var i = oldVersion - 1; i < newVersion - 1; i++) {
        try {
          await db.execute(migrationScripts[i]);
        } catch (error) {
          logError(error);
        }
      }
    }
  }
}
