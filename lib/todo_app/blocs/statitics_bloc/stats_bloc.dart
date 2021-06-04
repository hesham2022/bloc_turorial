import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_state.dart';

import 'statics _state.dart';
import 'statics_event.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final NotesBloc notesBloc;
  late StreamSubscription todosSubscription;

  StatsBloc({required this.notesBloc}) : super(StatsLoadInProgress()) {
    void onTodosStateChanged(state) {
      if (state is NotesLoadSuccess) {
        add(StatsUpdated(state.notes));
      }
    }

    onTodosStateChanged(notesBloc.state);
    todosSubscription = notesBloc.stream.listen(onTodosStateChanged);
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      final numActive =
          event.notes.where((todo) => !todo.complete).toList().length;
      final numCompleted =
          event.notes.where((todo) => todo.complete).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
