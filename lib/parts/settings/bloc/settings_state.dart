part of '../settings_part.dart';

/// [SettingsState].
class SettingsState extends Equatable {
  final Locale locale;
  final ThemeStyle theme;

  const SettingsState({
    required this.locale,
    required this.theme,
  });

  @override
  List<Object?> get props => [locale, theme];
}
