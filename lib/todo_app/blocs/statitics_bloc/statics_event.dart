import 'package:bloc_turorial/todo_app/data/model/note.dart';
import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Note> notes;

  const StatsUpdated(this.notes);

  @override
  List<Object> get props => [notes];

  @override
  String toString() => 'UpdateStats { notes: $notes }';
}
