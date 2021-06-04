import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_event.dart';
import 'package:bloc_turorial/todo_app/blocs/todo_bloc/notes_state.dart';
import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'edit_note.dart';

class NoteDetailPage extends StatelessWidget {
  final int noteId;

  const NoteDetailPage({Key? key, required this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
        final note = (state as NotesLoadSuccess)
            .notes
            .firstWhere((note) => noteId == note.id);
        return Scaffold(
          appBar: AppBar(
            actions: [editButton(context, note), deleteButton(context, note)],
          ),
          body: Padding(
              padding: EdgeInsets.all(12),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMd().format(note.createdTime),
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  Text(
                    note.description,
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  )
                ],
              )),
        );
      });

  Widget editButton(BuildContext context, Note note) => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        // refreshNote();
      });

  Widget deleteButton(BuildContext context, Note note) => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          BlocProvider.of<NotesBloc>(context).add(NoteDeleted(note));
          // await NotesDatabase.instance.delete(note.id!);

          Navigator.of(context).pop();
        },
      );
}
