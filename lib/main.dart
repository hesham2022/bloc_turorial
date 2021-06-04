import 'package:bloc_turorial/counter_app/counter_bloc.dart';
import 'package:bloc_turorial/movie_app/movie_app.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_event.dart';
import 'package:bloc_turorial/todo_app/data/reposetory/note_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_app/counter_page.dart';
import 'todo_app/todo_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotesBloc(noteRepository: NotesRepository())..add(NotesLoaded()),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        home: GeneralPage(),
      ),
    );
  }
}

class GeneralPage extends StatelessWidget {
  final bloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TodoApp())),
                child: Text('Todo App')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: bloc, child: MovieApp()))),
                child: Text('Movie App')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: bloc, child: CounterPage()))),
                child: Text('Counter App')),
          ],
        ),
      ),
    );
  }
}
