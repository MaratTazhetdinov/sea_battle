import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

class L10n {
  static const all = [
    Locale('en'),
    Locale('ru'),
    Locale('es'),
  ];

  static Map<String, Locale> languages = {
    'English': all[0],
    'Русский': all[1],
    'Español': all[2],
  };
}
