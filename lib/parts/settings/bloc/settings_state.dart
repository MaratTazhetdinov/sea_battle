part of '../settings_part.dart';

/// [SettingsState].
@props
@copyWith
class SettingsState extends Equatable {
  final Locale locale;
  final ThemeStyle theme;

  const SettingsState({
    required this.locale,
    required this.theme,
  });

  factory SettingsState.init() {
    return SettingsState(
      locale: L10n.all.first,
      theme: ThemeStyle.light,
    );
  }

  @override
  List<Object?> get props => _$SettingsStateProps(this);
}
