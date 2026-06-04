import 'package:plus_notes_app/core/exception/resource_not_found_exception.dart';
import 'package:plus_notes_app/features/notes/data/dto/create_note_dto.dart';
import 'package:plus_notes_app/features/notes/data/dto/update_note_dto.dart';
import 'package:plus_notes_app/features/notes/domain/model/note_model.dart';
import 'package:plus_notes_app/features/notes/domain/repository/note_repository.dart';

class NoteService {
  final NoteRepository _repository;

  NoteService(this._repository);

  Future<NoteModel> create(CreateNoteDTO dto) async {
    final note = NoteModel(
      title: dto.title,
      content: dto.content,
      userId: dto.userId,
      createdAt: DateTime.now(),
    );

    return await _repository.create(note);
  }

  Future<List<NoteModel>> findByUserId(int userId) async {
    return await _repository.findByUserId(userId);
  }

  Future<int> delete(int id) async {
    _assertExistsById(id);
    return await _repository.delete(id);
  }

  Future<NoteModel> update(UpdateNoteDTO dto) async {
    _assertExistsById(dto.id);
    return await _repository.update(dto);
  }

  Future<void> _assertExistsById(int id) async {
    if (!await _repository.existsById(id)) {
      throw ResourceNotFoundException(message: 'Anotação não encontrada.');
    }
  }
}
