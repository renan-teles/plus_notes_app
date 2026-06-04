class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int userId;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  NoteModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    String? createdAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt != null ? DateTime.parse(createdAt) : this.createdAt,
    );
  }
}
