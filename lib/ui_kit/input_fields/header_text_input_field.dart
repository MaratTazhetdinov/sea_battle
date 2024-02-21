import 'package:flutter/material.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';

class HeaderTextInputField extends StatelessWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextInputField textInputField;

  const HeaderTextInputField({
    super.key,
    required this.title,
    this.titleTextStyle,
    this.padding,
    this.crossAxisAlignment,
    required this.textInputField,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: titleTextStyle ?? theme.textTheme.titleMedium,
          ),
        ),
        textInputField,
      ],
    );
  }
}
