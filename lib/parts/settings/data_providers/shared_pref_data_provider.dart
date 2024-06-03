part of '../settings_part.dart';

/// [SharedPrefDataProvider].
class SharedPrefDataProvider extends ISettingsDataProvider {
  late final SharedPreferences? prefs;

  @override
  Future<String?> getLocale() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs?.getString('language');
  }

  @override
  Future<void> setLocale(String locale) async {
    await prefs?.setString('language', locale);
  }

  @override
  Future<String?> getTheme() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs?.getString('theme');
  }

  @override
  Future<void> setTheme(String theme) async {
    await prefs?.setString('theme', theme);
  }
}
