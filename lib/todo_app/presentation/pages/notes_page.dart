import 'package:bloc_turorial/todo_app/blocs/filttered/bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/state.dart';
import 'package:bloc_turorial/todo_app/blocs/statitics_bloc/statics%20_state.dart';
import 'package:bloc_turorial/todo_app/blocs/statitics_bloc/stats_bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/taps/tap_cupit.dart';
import 'package:bloc_turorial/todo_app/blocs/taps/tap_state.dart';
import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:bloc_turorial/todo_app/presentation/widgets/filtter_button.dart';
import 'package:bloc_turorial/todo_app/presentation/widgets/note_card.dart';
import 'package:bloc_turorial/todo_app/presentation/widgets/tap_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_note.dart';
import 'note_details.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TapCubit, AppTap>(
        builder: (_, state) => Scaffold(
          bottomNavigationBar: TabSelector(
            onTabSelected: (appTap) =>
                context.read<TapCubit>().updateTap(appTap),
            activeTab: state,
          ),
          appBar: AppBar(
            title: Text(
              'Notes',
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              FilterButton(
                visible: state == AppTap.filtered,
              ),
              SizedBox(width: 12)
            ],
          ),
          body: state == AppTap.state
              ? BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
                  if (state is StatsLoadSuccess)
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('active ${state.numActive}'),
                          SizedBox(
                            width: 30,
                          ),
                          Text('completed ${state.numCompleted}'),
                        ],
                      ),
                    );
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
              : BlocBuilder<FilteredNotesBloc, FilteredNotesState>(
                  builder: (_, state) {
                    if (state is FilteredNotesLoadInProgress)
                      return Center(child: CircularProgressIndicator());
                    return Center(
                      child: buildNotes(
                          (state as FilteredNotesLoadSuccess).filteredNotes),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditNotePage()),
              );
            },
          ),
        ),
      );

  Widget buildNotes(List<Note> notes) => ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, i) {
        final note = notes[i];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            ));

            // refreshNotes();
          },
          child: NoteCardWidget(note: note, index: i),
        );
      });
}
