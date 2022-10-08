import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase('notes.db');
    return _database!;
  }

  Future<void> deleteDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    await deleteDatabase(path);
  }

  Future<Database> initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $notesTable (
  ${NoteFields.id} $idType,
  ${NoteFields.isPinned} $boolType,
  ${NoteFields.title} $textType,
  ${NoteFields.colorID} $integerType,
  ${NoteFields.content} $textType,
  ${NoteFields.dueDate} $textType,
  ${NoteFields.isDone} $boolType,
  ${NoteFields.notifications} $boolType
)
''');
  }

  Future<Note> createNote(Note note) async {
    final db = await instance.database;

    final id = await db.insert(notesTable, note.toJSON());
    return note.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final map = await db.query(notesTable,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return Note.fromJSON(map.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<List<Note>> readNonPinnedNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.dueDate} ASC';
    final result = await db.query(notesTable,
        orderBy: orderBy, where: '${NoteFields.isPinned} = ?', whereArgs: [0]);

    return result.map((json) => Note.fromJSON(json)).toList();
  }

  Future<List<Note>> readNonPinnedNotesWithContent(String value) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        "SELECT * FROM notes WHERE isPinned = 0 AND (title LIKE '%$value%' OR content LIKE '%$value%') ORDER BY dueDate ASC");

    return result.map((json) => Note.fromJSON(json)).toList();
  }

  Future<List<Note>> readPinnedNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.dueDate} ASC';
    final result = await db.query(notesTable,
        orderBy: orderBy, where: '${NoteFields.isPinned} = ?', whereArgs: [1]);

    return result.map((json) => Note.fromJSON(json)).toList();
  }

  Future<List<Note>> readPinnedNotesWithContent(String value) async {
    final db = await instance.database;

    const orderBy = '${NoteFields.dueDate} ASC';
    final result = await db.rawQuery(
        "SELECT * FROM notes WHERE isPinned = 1 AND (title LIKE '%$value%' OR content LIKE '%$value%') ORDER BY dueDate ASC");

    return result.map((json) => Note.fromJSON(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(notesTable, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(notesTable, note.toJSON(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }
}
