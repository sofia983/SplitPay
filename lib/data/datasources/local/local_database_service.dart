import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

typedef RegistroDB = Map<String, dynamic>;

class LocalDatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = kIsWeb
        ? 'split_pay.db'
        : join(await getDatabasesPath(), 'split_pay.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE groups (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            currency TEXT NOT NULL,
            total_amount REAL NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE expenses (
            id TEXT PRIMARY KEY,
            group_id TEXT NOT NULL,
            description TEXT NOT NULL,
            amount REAL NOT NULL,
            currency TEXT NOT NULL,
            paid_by TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> cacheGroups(List<RegistroDB> groups) async {
    final db = await database;
    final batch = db.batch();
    for (final group in groups) {
      batch.insert(
        'groups',
        group,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<RegistroDB>> getCachedGroups() async {
    final db = await database;
    return await db.query('groups', orderBy: 'updated_at DESC');
  }

  Future<void> cacheExpenses(List<RegistroDB> expenses) async {
    final db = await database;
    final batch = db.batch();
    for (final expense in expenses) {
      batch.insert(
        'expenses',
        expense,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<RegistroDB>> getCachedExpensesByGroup(String groupId) async {
    final db = await database;
    return await db.query(
      'expenses',
      where: 'group_id = ?',
      whereArgs: [groupId],
      orderBy: 'created_at DESC',
    );
  }
}