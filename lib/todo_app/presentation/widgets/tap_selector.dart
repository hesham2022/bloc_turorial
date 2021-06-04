import 'package:bloc_turorial/todo_app/blocs/taps/tap_state.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTap activeTab;
  final Function(AppTap) onTabSelected;

  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTap.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTap.values[index]),
      items: AppTap.values.map((tab) {
        return BottomNavigationBarItem(
          label: tab == AppTap.filtered ? 'filter' : 'statics',
          icon: Icon(
            tab == AppTap.filtered ? Icons.list : Icons.show_chart,
          ),
        );
      }).toList(),
    );
  }
}
