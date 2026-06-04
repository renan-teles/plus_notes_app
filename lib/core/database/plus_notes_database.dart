import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Tables {
  static const users = 'users';
  static const notes = 'notes';
}

class PlusNotesDatabase {
  static const _databaseName = 'plus_notes.db';
  static const _databaseVersion = 1;

  static const _usersTable = Tables.users;
  static const _notesTable = Tables.notes;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<void> close() async {
    if (_database == null) return;

    await _database!.close();
    _database = null;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, _databaseName);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_usersTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password_hash TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');

    await db.execute('''
        CREATE TABLE $_notesTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_at TEXT NOT NULL,
          user_id INTEGER NOT NULL,

          FOREIGN KEY (user_id)
          REFERENCES users(id)
          ON DELETE CASCADE
        )
      ''');
  }
}
