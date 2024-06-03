part of '../settings_part.dart';

/// [SettingsRepository].
class SettingsRepository extends ISettingsRepository {
  /// [ISettingsDataProvider].
  final ISettingsDataProvider dataProvider;

  SettingsRepository({required this.dataProvider});

  @override
  Locale getLocale() {
    final stringLocale = dataProvider.getLocale();
    final locale = L10n.languages[stringLocale];
    if (locale case final locale?) {
      return locale;
    }
    final deviceLocale = Locale(Platform.localeName.substring(0, 3));
    if (L10n.languages.values.contains(deviceLocale)) {
      return deviceLocale;
    }
    return L10n.languages.values.first;
  }

  @override
  Future<void> setLocale(Locale locale) async {
    final stringLocale = L10n.languages.entries
        .firstWhereOrNull((entry) => entry.value == locale)
        ?.key;
    await dataProvider.setLocale(stringLocale ?? L10n.languages.keys.first);
  }

  @override
  ThemeStyle getTheme() {
    final themeString = dataProvider.getTheme();
    return ThemeStyle.values
            .firstWhereOrNull((theme) => theme.title == themeString) ??
        ThemeStyle.light;
  }

  @override
  Future<void> setTheme(ThemeStyle theme) async {
    await dataProvider.setTheme(theme.title);
  }
}
