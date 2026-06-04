import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plus_notes_app/features/notes/domain/model/note_model.dart';
import 'package:plus_notes_app/features/notes/presentation/pages/note_page.dart';
import 'package:plus_notes_app/shared/ui/widget/dialog_alert.dart';

class NoteCardWidget extends StatelessWidget {
  final VoidCallback onDelete;
  final NoteModel note;
  final bool deleting;

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.deleting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(note.createdAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NotePage(note: note)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.note)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      note.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                note.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700]),
              ),

              Row(
                children: [
                  Expanded(child: Text(formattedDate)),
                  deleting
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: () {
                            _showDeleteDialog(context);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return DialogAlert(
          title: 'Deletar Anotação',
          confirmText: 'Deletar',
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          content: const Text('Deseja deletar esta anotação?'),
          inverterConfirm: true,
          onConfirm: onDelete,
        );
      },
    );
  }
}
