import 'package:plus_notes_app/core/database/plus_notes_database.dart';
import 'package:plus_notes_app/features/auth/domain/model/user_model.dart';

class UserRepository {
  final PlusNotesDatabase _databaseHelper;

  UserRepository(this._databaseHelper);

  Future<void> create(UserModel model) async {
    final db = await _databaseHelper.database;
    await db.insert(Tables.users, model.toMap());
  }

  Future<UserModel?> findByEmail(String email) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      Tables.users,
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return UserModel.fromMap(result.first);
  }

  Future<bool> existsByEmail(String email) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      Tables.users,
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
