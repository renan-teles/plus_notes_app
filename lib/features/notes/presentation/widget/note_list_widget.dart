import 'package:flutter/material.dart';
import 'package:plus_notes_app/features/notes/presentation/provider/notes_provider.dart';
import 'package:plus_notes_app/features/notes/presentation/widget/note_card_widget.dart';
import 'package:plus_notes_app/shared/utils/view_state_utils.dart';
import 'package:provider/provider.dart';

class NoteListWidget extends StatelessWidget {
  const NoteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final notes = provider.notes;

    if (isLoading(provider.loadNotesState)) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError(provider.loadNotesState)) {
      return const Center(child: Text('Erro ao buscar anotações.'));
    } else if (notes.isEmpty) {
      return const Center(child: Text('Nenhuma anotação encontrado.'));
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return NoteCardWidget(
          note: note,
          onDelete: () async {
            await provider.delete(note.id!);
          },
          deleting: isLoading(provider.deleteState),
        );
      },
    );
  }
}
