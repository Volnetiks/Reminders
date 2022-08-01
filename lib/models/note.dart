const String notesTable = 'notes';

class NoteFields {}

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
}
