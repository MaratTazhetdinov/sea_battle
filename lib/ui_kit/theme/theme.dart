part of '../ui_kit_part.dart';

class AppTheme {
  final AppColors colorScheme;

  const AppTheme({required this.colorScheme});

  ThemeData get theme {
    final displayLarge = TextStyle(
      fontSize: 57,
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w400,
      color: colorScheme.firstTextColor,
    );
    final headlineMedium = TextStyle(
      fontSize: 28,
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w400,
      color: colorScheme.firstTextColor,
    );
    final headlineSmall = TextStyle(
      fontSize: 24,
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w400,
      color: colorScheme.firstTextColor,
    );
    final titleMedium = TextStyle(
      fontSize: 16,
      fontFamily: FontFamily.roboto,
      fontWeight: FontWeight.w400,
      color: colorScheme.firstTextColor,
    );

    return ThemeData(
      fontFamily: FontFamily.roboto,
      scaffoldBackgroundColor: colorScheme.scaffoldBackgroundColor,
      useMaterial3: false,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colorScheme.disabledButtonColor;
              } else {
                return colorScheme.activeButtonColor;
              }
            },
          ),
          foregroundColor:
              MaterialStatePropertyAll(colorScheme.buttonTextColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled) ||
                  states.contains(MaterialState.pressed)) {
                return 0;
              } else {
                return 10;
              }
            },
          ),
          shadowColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colorScheme.transparent;
              } else {
                return colorScheme.buttonShadowColor;
              }
            },
          ),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.all(16),
          ),
          textStyle: MaterialStatePropertyAll(titleMedium),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.scaffoldBackgroundColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: colorScheme.focusedInputBorderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: colorScheme.inputBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: colorScheme.errorInputBorderColor,
          ),
        ),
        errorMaxLines: 10,
      ),
      textTheme: TextTheme(
        displayLarge: displayLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleMedium: titleMedium,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.activeButtonColor,
      ),
    );
  }
}

extension ThemeMethods on BuildContext {
  ThemeData get theme => Theme.of(this);
}

///Extension for getting [AppColors] for a theme.
extension ThemeColors on ThemeData {
  ///Returns [AppColors] for the current theme's [Brightness].
  AppColors get colors {
    return AppColors.light();
  }
}
