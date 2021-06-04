import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/events.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/state.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_state.dart';
import 'package:bloc_turorial/todo_app/data/model/note.dart';

import 'visibilty.dart';

class FilteredNotesBloc extends Bloc<FilteredNotesEvent, FilteredNotesState> {
  final NotesBloc notesBloc;
  late StreamSubscription notesSubscription;

  FilteredNotesBloc({required this.notesBloc})
      : super(
          notesBloc.state is NotesLoadSuccess
              ? FilteredNotesLoadSuccess(
                  VisibilityFilter.all,
                  (notesBloc.state as NotesLoadSuccess).notes,
                )
              : FilteredNotesLoadInProgress(),
        ) {
    notesSubscription = notesBloc.stream.listen((state) {
      if (state is NotesLoadSuccess) {
        add(NoteUpdated((notesBloc.state as NotesLoadSuccess).notes));
      }
    });
  }

  @override
  Stream<FilteredNotesState> mapEventToState(FilteredNotesEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is NoteUpdated) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredNotesState> _mapFilterUpdatedToState(
    FilterUpdated event,
  ) async* {
    if (notesBloc.state is NotesLoadSuccess) {
      yield FilteredNotesLoadSuccess(
        event.filter,
        _mapTodosToFilteredTodos(
          (notesBloc.state as NotesLoadSuccess).notes,
          event.filter,
        ),
      );
    }
  }

  Stream<FilteredNotesState> _mapTodosUpdatedToState(
    NoteUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredNotesLoadSuccess
        ? (state as FilteredNotesLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredNotesLoadSuccess(
      visibilityFilter,
      _mapTodosToFilteredTodos(
        (notesBloc.state as NotesLoadSuccess).notes,
        visibilityFilter,
      ),
    );
  }

  List<Note> _mapTodosToFilteredTodos(
      List<Note> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    notesSubscription.cancel();
    return super.close();
  }
}
