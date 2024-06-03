part of '../settings_part.dart';

class SettingsEvent {}

/// Loads settings from local database.
class _SettingsLoaded extends SettingsEvent {}

/// Saves locale to local database.
class LocaleSet extends SettingsEvent {
  final Locale locale;

  LocaleSet(this.locale);
}

/// Saves theme to local database.
class ThemeSet extends SettingsEvent {
  final ThemeStyle theme;

  ThemeSet(this.theme);
}
