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

  Future<Database> initDatabase(String dbPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbPath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $notesTable (
  ${NoteFields.id} $idType,
  ${NoteFields.isPinned} $boolType
  ${NoteFields.title} $textType,
  ${NoteFields.content} $textType,
  ${NoteFields.dueDate} $textType
)
''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
