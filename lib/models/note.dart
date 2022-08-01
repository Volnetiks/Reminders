const String notesTable = 'notes';

class NoteFields {
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
}
