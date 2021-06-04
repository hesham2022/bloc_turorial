import 'package:bloc_turorial/todo_app/blocs/taps/tap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TapCubit extends Cubit<AppTap> {
  TapCubit() : super(AppTap.filtered);
  void updateTap(AppTap appTap) => emit(appTap);
}
