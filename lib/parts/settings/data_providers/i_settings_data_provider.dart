part of '../settings_part.dart';

/// [ISettingsDataProvider].
abstract class ISettingsDataProvider {
  /// Gets locale from local database.
  Future<String?> getLocale();

  /// Save locale in local database.
  Future<void> setLocale(String locale);

  /// Gets theme from local database.
  Future<String?> getTheme();

  /// Save theme in local database.
  Future<void> setTheme(String theme);
}
