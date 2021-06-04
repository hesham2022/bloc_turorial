import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0);
//
//   @override
//   Stream<int> mapEventToState(CounterEvent event) async* {
//     if (event == CounterEvent.increase) {
//       yield state + 1;
//     }
//     if (event == CounterEvent.decrease) {
//       yield state - 1;
//     }
//   }
// }
//
// enum CounterEvent {
//   increase,
//   decrease,
// }

// class CounterBloc extends Bloc<bool,String>{
//   CounterBloc() : super('true');
//
//   @override
//   Stream<String> mapEventToState(bool event)async* {
//     if(event==true){
//       yield state-1;
//     }
//     if(event==false){
//       yield state+1;
//     }
//
//
//   }
//
// }
class CounterBloc extends Cubit<int> {
  CounterBloc() : super(0);

  void increase() => emit(state + 1);
  void decrease() => emit(state - 1);
}

class CounterDoubleBloc extends Cubit<double> {
  final CounterBloc counterBloc;
  late StreamSubscription subscription;
  CounterDoubleBloc(this.counterBloc) : super(0) {
    subscription = counterBloc.stream.listen((event) {});
  }

  // void increase() => emit(state + 1);
  // void decrease() => emit(state - 1);
}

class CounterStringBloc extends Cubit<String> {
  final CounterBloc counterBloc;
  late StreamSubscription subscription;
  CounterStringBloc(this.counterBloc) : super('') {
    subscription = counterBloc.stream.listen((event) {
      emit(event.toString());
    });
  }
  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}
