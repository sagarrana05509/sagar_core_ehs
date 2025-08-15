import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserLocalStorageRepository {
  static final UserLocalStorageRepository _instance =
      UserLocalStorageRepository._internal();
  factory UserLocalStorageRepository() => _instance;
  UserLocalStorageRepository._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            gender TEXT,
            selectedGames TEXT,
            visitedCities TEXT,
            selectedBooks TEXT,
            isSync INTEGER
          )
        ''');
      },
    );
  }

  /// Insert User
  Future<int> insertUser(UserProfile profile) async {
    final db = await database;
    var map = profile.sqfLitetoMap();
    return await db.insert('users', map);
  }

  /// Get All Users
  Future<List<UserProfile>> getAllUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((map) => UserProfile.fromSqfLiteMap(map)).toList();
  }

  /// Update Sync Status
  Future<int> updateSyncStatus(int id, bool status) async {
    final db = await database;
    return await db.update(
      'users',
      {'isSync': status ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<UserProfile>> getUnsyncedUsers() async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'isSync = ?',
      whereArgs: [0], // 0 means false
    );
    return result.map((map) => UserProfile.fromSqfLiteMap(map)).toList();
  }

  Future<int> markAllUsersAsSynced() async {
    final db = await database;
    return await db.update(
      'users',
      {'isSync': 1},
      where: 'isSync = ?',
      whereArgs: [0],
    );
  }

  Future<List<UserProfile>> searchUsers(String query) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'name LIKE ?',
      whereArgs: [
        '%$query%', // Search in name
      ],
    );

    return results.map((map) => UserProfile.fromSqfLiteMap(map)).toList();
  }

  Future<List<UserProfile>> getUsersSortedByName({
    bool ascending = true,
  }) async {
    final order = ascending ? 'ASC' : 'DESC';
    final db = await database;
    final results = await db.query(
      'users',
      orderBy: 'name $order', // name ASC or name DESC
    );

    return results.map((map) => UserProfile.fromSqfLiteMap(map)).toList();
  }

  Future<List<UserProfile>> getUsersByAgeRange({
    required int minAge,
    required int maxAge,
  }) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'age >= ? AND age <= ?',
      whereArgs: [minAge, maxAge],
      orderBy: 'age ASC', // Optional: sort by age
    );

    return results.map((map) => UserProfile.fromSqfLiteMap(map)).toList();
  }

  Future<void> replaceUserProfiles(List<UserProfile> profiles) async {
    final db = await database;
    await db.transaction((txn) async {
      final count = Sqflite.firstIntValue(
        await txn.rawQuery('SELECT COUNT(*) FROM users'),
      );

      if (count != null && count > 0) {
        await txn.delete('users');
      }

      for (var profile in profiles) {
        await txn.insert(
          'users',
          profile.sqfLitetoMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<UserProfile>> getUsersGroupedBySync(
    int minAge,
    int maxAge,
    bool notSynced,
    bool synced,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      notSynced && synced
          ? 'SELECT * FROM users WHERE age BETWEEN ? AND ? AND (isSync = 0 OR isSync = 1)'
          : 'SELECT * FROM users WHERE age BETWEEN ? AND ? AND (isSync = ${notSynced ? 0 : 1})',
      [minAge, maxAge],
    );

    List<UserProfile> profile = [];

    for (var map in maps) {
      profile.add(UserProfile.fromSqfLiteMap(map));
    }

    return profile;
  }
}
