import 'package:plus_notes_app/core/database/plus_notes_database.dart';
import 'package:plus_notes_app/core/exception/database_exception.dart';
import 'package:plus_notes_app/features/notes/data/dto/update_note_dto.dart';
import 'package:plus_notes_app/features/notes/domain/model/note_model.dart';

class NoteRepository {
  final PlusNotesDatabase _databaseHelper;

  NoteRepository(this._databaseHelper);

  Future<NoteModel> create(NoteModel model) async {
    final db = await _databaseHelper.database;

    final id = await db.insert(Tables.notes, model.toMap());

    return model.copyWith(id: id);
  }

  Future<List<NoteModel>> findByUserId(int userId) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      Tables.notes,
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (result.isEmpty) {
      return [];
    }

    return result.map((note) => NoteModel.fromMap(note)).toList();
  }

  Future<NoteModel?> findById(int id) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      Tables.notes,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return NoteModel.fromMap(result.first);
  }

  Future<NoteModel> update(UpdateNoteDTO dto) async {
    final db = await _databaseHelper.database;

    final rowsAffected = await db.update(
      Tables.notes,
      {'title': dto.title, 'content': dto.content},
      where: 'id = ?',
      whereArgs: [dto.id],
    );

    if (rowsAffected == 0) {
      throw DatabaseException(message: 'Erro ao atualizar anotação.');
    }

    final updatedNote = await findById(dto.id);
    if (updatedNote == null) {
      throw DatabaseException(
        message: 'Erro ao recuperar anotação atualizada.',
      );
    }

    return updatedNote;
  }

  Future<int> delete(int id) async {
    final db = await _databaseHelper.database;

    final rowsAffected = await db.delete(
      Tables.notes,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (rowsAffected == 0) {
      throw DatabaseException(message: 'Erro ao remover anotação.');
    }

    return id;
  }

  Future<bool> existsById(int id) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      Tables.notes,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
