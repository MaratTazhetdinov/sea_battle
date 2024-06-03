part of '../settings_part.dart';

/// [ISettingsRepository].
abstract class ISettingsRepository {
  /// Gets locale from local database.
  Future<Locale> getLocale();

  /// Save locale in local database.
  Future<void> setLocale(Locale locale);

  /// Gets theme from local database.
  Future<ThemeStyle> getTheme();

  /// Save theme in local database.
  Future<void> setTheme(ThemeStyle theme);
}
