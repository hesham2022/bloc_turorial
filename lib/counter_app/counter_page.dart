import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterStringBloc(context.read<CounterBloc>()),
        child: _CounterBody());
  }
}

mixin B<W extends StatefulWidget, Bloc extends BlocBase> on State<W> {
  Bloc get bloc => BlocProvider.of<Bloc>(context);
}

class _CounterBody extends StatefulWidget {
  @override
  __CounterBodyState createState() => __CounterBodyState();
}

class __CounterBodyState extends State<_CounterBody>
    with B<_CounterBody, CounterBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: bloc.increase,
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: context.read<CounterBloc>().increase,
              child: Icon(Icons.remove),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<CounterBloc, int>(builder: (context, state) {
            return Column(
              children: [
                Text(
                  '$state',
                  style: Theme.of(context).textTheme.headline3,
                ),
                BlocBuilder<CounterStringBloc, String>(
                    builder: (_, state) => Text('test $state'))
              ],
            );
          }),
        ));
  }
}
