import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_event.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_state.dart';
import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:bloc_turorial/todo_app/data/reposetory/note_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotesBloc extends Bloc<NoteEvent, NotesState> {
  final NotesRepository noteRepository;

  NotesBloc({required this.noteRepository}) : super(NotesLoadInProgress()) {
    print("--------------------------------");
    IO.Socket socket = IO.io('http://192.168.1.3:8080');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  @override
  Stream<NotesState> mapEventToState(NoteEvent event) async* {
    if (event is NotesLoaded) {
      yield* _mapTodosLoadedToState();
    } else if (event is NoteAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is NoteUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is NoteDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<NotesState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.noteRepository.getAll();
      yield NotesLoadSuccess(todos);
    } catch (_) {
      yield NotesLoadFailure();
    }
  }

  Stream<NotesState> _mapTodoAddedToState(NoteAdded event) async* {
    if (state is NotesLoadSuccess) {
      final note = await noteRepository.createOne(event.note);
      final List<Note> updatedNotes =
          List.from((state as NotesLoadSuccess).notes)..add(note);
      yield NotesLoadSuccess(updatedNotes);
    }
  }

  Stream<NotesState> _mapTodoUpdatedToState(NoteUpdated event) async* {
    if (state is NotesLoadSuccess) {
      await noteRepository.updateNote(event.note);
      final List<Note> updatedNotes =
          (state as NotesLoadSuccess).notes.map((note) {
        return note.id == event.note.id ? event.note : note;
      }).toList();
      yield NotesLoadSuccess(updatedNotes);
    }
  }

  Stream<NotesState> _mapTodoDeletedToState(NoteDeleted event) async* {
    if (state is NotesLoadSuccess) {
      await noteRepository.deleteNote(event.note.id!);
      final updatedNotes = (state as NotesLoadSuccess)
          .notes
          .where((todo) => todo.id != event.note.id)
          .toList();
      yield NotesLoadSuccess(updatedNotes);
    }
  }

  Stream<NotesState> _mapToggleAllToState() async* {
    if (state is NotesLoadSuccess) {
      final allComplete =
          (state as NotesLoadSuccess).notes.every((note) => note.complete);
      final List<Note> updatedNotes =
          (state as NotesLoadSuccess).notes.map((e) {
        final updatedNote = e.copy(complete: !allComplete);
        noteRepository.updateNote(updatedNote);
        return updatedNote;
      }).toList();

      yield NotesLoadSuccess(updatedNotes);
    }
  }

  Stream<NotesState> _mapClearCompletedToState() async* {
    if (state is NotesLoadSuccess) {
      final List<Note> updatedTodos =
          (state as NotesLoadSuccess).notes.where((note) {
        if (note.complete) {
          noteRepository.deleteNote(note.id!);
        }

        return !note.complete;
      }).toList();
      yield NotesLoadSuccess(updatedTodos);
    }
  }
}
