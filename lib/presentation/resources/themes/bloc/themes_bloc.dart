import 'package:bloc/bloc.dart';

import 'themes_event.dart';
import 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(ThemesState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<ThemesState> emit) async {
    emit(state.clone());
  }
}
