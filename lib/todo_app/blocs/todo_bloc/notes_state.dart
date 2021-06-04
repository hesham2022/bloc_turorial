import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesLoadInProgress extends NotesState {}

class NotesLoadSuccess extends NotesState {
  final List<Note> notes;

  const NotesLoadSuccess([this.notes = const []]);

  @override
  List<Object> get props => [notes];

  @override
  String toString() => 'NotesLoadSuccess { notes: $notes }';
}

class NotesLoadFailure extends NotesState {}
