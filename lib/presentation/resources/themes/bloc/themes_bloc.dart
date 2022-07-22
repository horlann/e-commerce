import 'package:bloc/bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_event.dart';
import 'package:kurilki/presentation/resources/themes/dark_theme.dart';
import 'package:kurilki/presentation/resources/themes/light_theme.dart';

import 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(ThemesState().init()) {
    on<ThemeInitEvent>(_init);
    on<UpdateThemeEvent>(_updateTheme);
  }

  // final ApplicationThemeUseCase _applicationThemeUseCase;
  // final UpdateApplicationThemeUseCase _updateApplicationThemeUseCase;
  AbstractTheme _currentTheme = DarkTheme();

  AbstractTheme get theme => _currentTheme;

  void _init(ThemeInitEvent event, Emitter<ThemesState> emit) async {
    // final theme = await _applicationThemeUseCase.call(NoParams());
    // theme.fold((l) => _currentTheme = DarkTheme(), (r) {
    //   if (r.toString() == Theme.light.name) {
    //     _currentTheme = LightTheme();
    //   } else {
    //     _currentTheme = DarkTheme();
    //   }
    // });
  }

  void _updateTheme(UpdateThemeEvent event, Emitter<ThemesState> emit) async {
    if (_currentTheme is LightTheme) {
      _currentTheme = DarkTheme();
      //  _updateApplicationThemeUseCase.call(UpdateApplicationThemeParams(Theme.dark.name));
    } else {
      _currentTheme = LightTheme();
      // _updateApplicationThemeUseCase.call(UpdateApplicationThemeParams(Theme.light.name));
    }
    emit(ThemesState().clone());
  }
}

enum Theme { dark, light }
