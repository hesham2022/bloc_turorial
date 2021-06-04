import 'package:bloc_turorial/todo_app/data/model/note.dart';

import '../db.dart';

class NotesRepository {
  Future<List<Note>> getAll() async =>
      await NotesDatabase.instance.readAllNotes();
  Future<Note> getNote(int id) async =>
      await NotesDatabase.instance.readNote(id);

  Future<int> updateNote(Note note) async =>
      await NotesDatabase.instance.update(note);
  Future<int> deleteNote(int id) async =>
      await NotesDatabase.instance.delete(id);

  Future<Note> createOne(Note note) async =>
      await NotesDatabase.instance.create(note);
}
