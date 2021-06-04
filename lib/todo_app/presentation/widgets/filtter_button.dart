import 'package:bloc_turorial/todo_app/blocs/filttered/bloc.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/events.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/state.dart';
import 'package:bloc_turorial/todo_app/blocs/filttered/visibilty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({required this.visible, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: Theme.of(context).accentColor);
    return BlocBuilder<FilteredNotesBloc, FilteredNotesState>(
        builder: (context, state) {
      final button = _Button(
        onSelected: (filter) {
          BlocProvider.of<FilteredNotesBloc>(context)
              .add(FilterUpdated(filter));
        },
        activeFilter: state is FilteredNotesLoadSuccess
            ? state.activeFilter
            : VisibilityFilter.all,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle!,
      );
      return AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 150),
        child: visible ? button : IgnorePointer(child: button),
      );
    });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onSelected,
    required this.activeFilter,
    required this.activeStyle,
    required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.all,
          child: Text(
            'show all',
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.active,
          child: Text(
            'show active',
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.completed,
          child: Text(
            'show complete',
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
