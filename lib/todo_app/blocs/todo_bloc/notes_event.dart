import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NotesLoaded extends NoteEvent {}

class NoteAdded extends NoteEvent {
  final Note note;

  const NoteAdded(this.note);

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'NoteAdded { note: $note }';
}

class NoteUpdated extends NoteEvent {
  final Note note;

  const NoteUpdated(this.note);

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'NoteUpdated { updatedNote: $note }';
}

class NoteDeleted extends NoteEvent {
  final Note note;

  const NoteDeleted(this.note);

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'NoteDeleted { note: $note }';
}

class ClearCompleted extends NoteEvent {}

class ToggleAll extends NoteEvent {}
