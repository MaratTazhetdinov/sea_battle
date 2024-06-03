part of '../settings_part.dart';

class SettingsEvent {}

/// Changes app locale.
class LanguagedChanged extends SettingsEvent {
  final Locale locale;

  LanguagedChanged(this.locale);
}

/// Changes theme style.
class ThemeChanged extends SettingsEvent {
  final ThemeStyle theme;

  ThemeChanged(this.theme);
}
