part of '../settings_part.dart';

/// [SettingsRepository].
class SettingsRepository extends ISettingsRepository {
  /// [ISettingsDataProvider].
  final ISettingsDataProvider dataProvider;

  SettingsRepository({required this.dataProvider});

  @override
  Future<Locale> getLocale() async {
    final stringLocale = await dataProvider.getLocale();
    final locale = L10n.languages[stringLocale];
    if (locale case final locale?) {
      return locale;
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
  Future<ThemeStyle> getTheme() async {
    final themeString = await dataProvider.getTheme();
    return ThemeStyle.values
            .firstWhereOrNull((theme) => theme.title == themeString) ??
        ThemeStyle.light;
  }

  @override
  Future<void> setTheme(ThemeStyle theme) async {
    await dataProvider.setTheme(theme.title);
  }
}
