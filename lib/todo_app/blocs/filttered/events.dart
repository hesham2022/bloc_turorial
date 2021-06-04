import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:equatable/equatable.dart';

import 'visibilty.dart';

abstract class FilteredNotesEvent extends Equatable {
  const FilteredNotesEvent();
}

class FilterUpdated extends FilteredNotesEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class NoteUpdated extends FilteredNotesEvent {
  final List<Note> notes;

  const NoteUpdated(this.notes);

  @override
  List<Object> get props => [notes];

  @override
  String toString() => 'NoteUpdated { notes: $notes }';
}
