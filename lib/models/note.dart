const String notesTable = 'notes';

class NoteFields {
  static const List<String> values = [
    id,
    isPinned,
    title,
    content,
    colorID,
    dueDate
  ];

  static const String id = "_id";
  static const String isPinned = "isPinned";
  static const String title = "title";
  static const String content = "content";
  static const String colorID = "colorID";
  static const String dueDate = "dueDate";
}

class Note {
  final int? id;
  final bool isPinned;
  final String title;
  final String content;
  final int colorID;
  final DateTime dueDate;

  const Note(
      {this.id,
      required this.isPinned,
      required this.title,
      required this.content,
      required this.colorID,
      required this.dueDate});

  Map<String, Object?> toJSON() => {
        NoteFields.id: id,
        NoteFields.isPinned: isPinned ? 1 : 0,
        NoteFields.title: title,
        NoteFields.content: content,
        NoteFields.dueDate: dueDate.toIso8601String()
      };

  static Note fromJSON(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      title: json[NoteFields.title] as String,
      content: json[NoteFields.content] as String,
      dueDate: DateTime.parse(json[NoteFields.dueDate] as String),
      colorID: json[NoteFields.colorID] as int,
      isPinned: json[NoteFields.isPinned] == 1);

  Note copy({
    int? id,
    bool? isPinned,
    String? title,
    String? content,
    DateTime? dueDate,
    int? colorID,
  }) =>
      Note(
          id: id ?? this.id,
          isPinned: isPinned ?? this.isPinned,
          title: title ?? this.title,
          content: content ?? this.content,
          dueDate: dueDate ?? this.dueDate,
          colorID: colorID ?? this.colorID);
}
