import 'package:flutter/material.dart';
import 'package:plus_notes_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:plus_notes_app/features/notes/presentation/pages/note_page.dart';
import 'package:plus_notes_app/features/notes/presentation/provider/notes_provider.dart';
import 'package:plus_notes_app/features/notes/presentation/widget/note_list_widget.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotesPageState();
  }
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = context.read<AuthProvider>().currentUser;
      if (user == null) return;

      await context.read<NotesProvider>().loadUserNotes(user.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Anotações')),
      body: const NoteListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
