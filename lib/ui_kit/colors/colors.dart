part of '../ui_kit_part.dart';

class AppColors {
  final Color firstTextColor;
  final Color secondTextColor;
  final Color transparent;
  final Color scaffoldBackgroundColor;
  final Color activeButtonColor;
  final Color disabledButtonColor;
  final Color buttonShadowColor;
  final Color inputBorderColor;
  final Color focusedInputBorderColor;
  final Color errorInputBorderColor;
  final Color buttonTextColor;
  final Color alignedShipColor;
  final Color possibleShipAlignmentColor;

  AppColors.light()
      : firstTextColor = Colors.black,
        secondTextColor = Colors.grey,
        transparent = Colors.transparent,
        scaffoldBackgroundColor = Colors.white,
        activeButtonColor = Colors.purple,
        disabledButtonColor = Colors.grey,
        buttonShadowColor = Colors.black,
        inputBorderColor = Colors.grey,
        focusedInputBorderColor = Colors.black,
        errorInputBorderColor = Colors.red,
        buttonTextColor = Colors.white,
        alignedShipColor = Colors.blue,
        possibleShipAlignmentColor = Colors.amber;

  AppColors.dark()
      : firstTextColor = Colors.white,
        secondTextColor = Colors.grey,
        transparent = Colors.transparent,
        scaffoldBackgroundColor = Colors.black,
        activeButtonColor = Colors.purple,
        disabledButtonColor = Colors.grey,
        buttonShadowColor = Colors.white,
        inputBorderColor = Colors.grey,
        focusedInputBorderColor = Colors.white,
        errorInputBorderColor = Colors.red,
        buttonTextColor = Colors.white,
        alignedShipColor = Colors.blue,
        possibleShipAlignmentColor = Colors.amber;
}
