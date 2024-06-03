part of '../settings_part.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository settingsRepository;

  SettingsBloc({required this.settingsRepository})
      : super(SettingsState.init()) {
    on<_SettingsLoaded>(_onSettingsLoaded);
    on<LocaleSet>(_onLocaleSet);
    on<ThemeSet>(_onThemeSet);
    add(_SettingsLoaded());
  }

  Future<void> _onSettingsLoaded(
          _SettingsLoaded event, Emitter<SettingsState> emit) async =>
      emit(SettingsState(
          locale: settingsRepository.getLocale(),
          theme: settingsRepository.getTheme()));

  Future<void> _onLocaleSet(
      LocaleSet event, Emitter<SettingsState> emit) async {
    await settingsRepository.setLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onThemeSet(ThemeSet event, Emitter<SettingsState> emit) async {
    await settingsRepository.setTheme(event.theme);
    emit(state.copyWith(theme: event.theme));
  }
}
