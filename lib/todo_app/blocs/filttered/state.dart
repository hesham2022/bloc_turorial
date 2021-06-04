import 'package:bloc_turorial/todo_app/blocs/filttered/visibilty.dart';
import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:equatable/equatable.dart';

abstract class FilteredNotesState extends Equatable {
  const FilteredNotesState();

  @override
  List<Object> get props => [];
}

class FilteredNotesLoadInProgress extends FilteredNotesState {}

class FilteredNotesLoadSuccess extends FilteredNotesState {
  final List<Note> filteredNotes;
  final VisibilityFilter activeFilter;

  const FilteredNotesLoadSuccess(
    this.activeFilter,
    this.filteredNotes,
  );

  @override
  List<Object> get props => [filteredNotes, activeFilter];

  @override
  String toString() {
    return 'FilteredNotesLoadSuccess { filteredTodos: $filteredNotes, activeFilter: $activeFilter }';
  }
}
