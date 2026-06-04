import 'package:flutter/foundation.dart';
import 'package:plus_notes_app/features/notes/data/dto/create_note_dto.dart';
import 'package:plus_notes_app/features/notes/data/dto/update_note_dto.dart';
import 'package:plus_notes_app/features/notes/domain/model/note_model.dart';
import 'package:plus_notes_app/features/notes/domain/service/note_service.dart';
import 'package:plus_notes_app/shared/types/view_state_enum.dart';

class NotesProvider extends ChangeNotifier {
  final NoteService _service;

  NotesProvider(this._service);

  ViewState createState = ViewState.idle;
  ViewState deleteState = ViewState.idle;
  ViewState updateState = ViewState.idle;

  ViewState loadNotesState = ViewState.idle;
  List<NoteModel> notes = [];

  String errorMessage = '';

  Future<void> loadUserNotes(int userId) async {
    loadNotesState = ViewState.loading;
    notifyListeners();

    notes = await _service.findByUserId(userId);
    loadNotesState = ViewState.success;

    notifyListeners();
  }

  Future<void> create(CreateNoteDTO dto) async {
    createState = ViewState.loading;
    errorMessage = '';

    notifyListeners();

    try {
      final note = await _service.create(dto);

      notes.insert(0, note);

      createState = ViewState.success;
    } catch (e) {
      createState = ViewState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> delete(int id) async {
    deleteState = ViewState.loading;
    errorMessage = '';

    notifyListeners();

    try {
      await _service.delete(id);

      deleteState = ViewState.success;

      notes.removeWhere((note) => note.id == id);
    } catch (e) {
      deleteState = ViewState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> update(UpdateNoteDTO dto) async {
    updateState = ViewState.loading;
    errorMessage = '';

    notifyListeners();

    try {
      final NoteModel updatedNote = await _service.update(dto);

      final index = notes.indexWhere((note) => note.id! == updatedNote.id);
      if (index != -1) {
        notes[index] = updatedNote;
      }

      updateState = ViewState.success;
    } catch (e) {
      updateState = ViewState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
