class CreateNoteDTO {
  final int? id;
  final int userId;
  final String title;
  final String content;

  const CreateNoteDTO({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
  });
}
