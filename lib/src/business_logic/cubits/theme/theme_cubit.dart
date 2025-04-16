import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_care/core/app_theme.dart';
import 'package:dental_care/src/business_logic/cubits/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = prefs.getBool('isLightTheme') ?? true;
    emit(
      ThemeState(
        theme:
            isLight
                ? AppThemes.appThemeData[AppTheme.lightTheme]!
                : AppThemes.appThemeData[AppTheme.darkTheme]!,
      ),
    );
  }

  Future<void> switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.theme == AppThemes.appThemeData[AppTheme.lightTheme]) {
      await prefs.setBool('isLightTheme', false);
      emit(state.copyWith(theme: AppThemes.appThemeData[AppTheme.darkTheme]!));
    } else {
      await prefs.setBool('isLightTheme', true);
      emit(state.copyWith(theme: AppThemes.appThemeData[AppTheme.lightTheme]!));
    }
  }

  bool get isLightTheme =>
      state.theme == AppThemes.appThemeData[AppTheme.lightTheme] ? true : false;
}
