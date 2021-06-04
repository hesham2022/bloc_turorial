import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/filttered/bloc.dart';
import 'blocs/statitics_bloc/stats_bloc.dart';
import 'blocs/taps/tap_cupit.dart';
import 'blocs/todo_bloc/notes_bloc.dart';
import 'presentation/pages/notes_page.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => TapCubit()),
      BlocProvider(
          create: (_) =>
              FilteredNotesBloc(notesBloc: context.read<NotesBloc>())),
      BlocProvider(
          create: (_) => StatsBloc(notesBloc: context.read<NotesBloc>())),
    ], child: NotesPage());
  }
}
