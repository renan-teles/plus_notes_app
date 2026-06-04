import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:plus_notes_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:plus_notes_app/features/notes/data/dto/create_note_dto.dart';
import 'package:plus_notes_app/features/notes/data/dto/update_note_dto.dart';
import 'package:plus_notes_app/features/notes/domain/model/note_model.dart';
import 'package:plus_notes_app/features/notes/presentation/provider/notes_provider.dart';
import 'package:plus_notes_app/shared/types/global_message_type_enum.dart';
import 'package:plus_notes_app/shared/ui/providers/global_message_provider.dart';
import 'package:plus_notes_app/shared/utils/view_state_utils.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final NoteModel? note;

  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController(text: '');
  final _contentController = TextEditingController(text: '');

  String _originalTitle = '';
  String _originalContent = '';

  NoteModel? get note => widget.note;
  bool get isUpdateRole => widget.note != null;

  bool get _hasUnsavedChanges {
    return _titleController.text.trim() != _originalTitle ||
        _contentController.text.trim() != _originalContent;
  }

  @override
  void initState() {
    super.initState();

    if (isUpdateRole) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
      _originalTitle = note!.title;
      _originalContent = note!.content;
      return;
    }

    _originalTitle = _titleController.text.trim();
    _originalContent = _contentController.text.trim();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _originalTitle = '';
    _originalContent = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await _onPop(didPop, result, context);
      },
      child: _buildMainLayout(context),
    );
  }

  Widget _buildMainLayout(BuildContext context) {
    final provider = context.watch<NotesProvider>();

    final bool loadingIs =
        isLoading(provider.createState) || isLoading(provider.updateState);

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdateRole ? 'Editar anotação' : 'Criar Anotação'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: loadingIs
            ? null
            : () async {
                await _submit(context);
              },
        icon: loadingIs
            ? const CircularProgressIndicator()
            : const Icon(Icons.save),
        label: const Text('Salvar'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  validator: RequiredValidator(
                    errorText: 'Título obrigatório',
                  ).call,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    border: InputBorder.none,
                  ),
                ),

                const Divider(height: 16),

                Expanded(
                  child: TextFormField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Comece a escrever sua anotação...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_hasUnsavedChanges) return;

    if (isUpdateRole) {
      await _update(context);
    } else {
      await _create(context);
    }

    _originalTitle = _titleController.text.trim();
    _originalContent = _contentController.text.trim();
  }

  Future<void> _update(BuildContext context) async {
    final provider = context.read<NotesProvider>();
    final message = context.read<GlobalMessageProvider>();

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    final dto = UpdateNoteDTO(id: note!.id!, content: content, title: title);
    await provider.update(dto);

    if (isSuccess(provider.updateState)) {
      message.show('Anotação atualizada com sucesso.', MessageType.success);
      return;
    }

    message.show(provider.errorMessage, MessageType.error);
  }

  Future<void> _create(BuildContext context) async {
    final notesProvider = context.read<NotesProvider>();
    final message = context.read<GlobalMessageProvider>();
    final userProvider = context.read<AuthProvider>();

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    final dto = CreateNoteDTO(
      userId: userProvider.currentUser!.id!,
      content: content,
      title: title,
    );

    await notesProvider.create(dto);

    if (isSuccess(notesProvider.createState)) {
      message.show('Anotação criada com sucesso.', MessageType.success);
      return;
    }

    message.show(notesProvider.errorMessage, MessageType.error);
  }

  Future<void> _onPop(
    dynamic didPop,
    dynamic result,
    BuildContext context,
  ) async {
    if (didPop) return;

    if (!_hasUnsavedChanges) {
      Navigator.pop(context);
      return;
    }

    final sholdLeave = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Sair sem salvar?'),
          content: const Text(
            'Tem certeza que deseja sair sem salvar a anotação',
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Sair'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (sholdLeave == true && context.mounted) {
      Navigator.pop(context);
    }
  }
}
