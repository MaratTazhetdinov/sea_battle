part of '../settings_part.dart';

/// [SharedPrefDataProvider].
class SharedPrefDataProvider extends ISettingsDataProvider {
  final SharedPreferences prefs;

  SharedPrefDataProvider(this.prefs);

  @override
  String? getLocale() {
    return prefs.getString('language');
  }

  @override
  Future<void> setLocale(String locale) async {
    await prefs.setString('language', locale);
  }

  @override
  String? getTheme() {
    return prefs.getString('theme');
  }

  @override
  Future<void> setTheme(String theme) async {
    await prefs.setString('theme', theme);
  }
}
