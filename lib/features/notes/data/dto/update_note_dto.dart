class UpdateNoteDTO {
  final int id;
  final String title;
  final String content;

  const UpdateNoteDTO({
    required this.id,
    required this.title,
    required this.content,
  });
}
