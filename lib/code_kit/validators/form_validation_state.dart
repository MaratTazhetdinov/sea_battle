part of '../code_kit_part.dart';

/// {@template applicationData}
/// Стейт с данными и колбэком о том успешна ли валидация формы или нет
/// {@endtemplate}
abstract class FormValidationState<T extends StatefulWidget> extends State<T> {
  /// Ключ для формы
  final formKey = GlobalKey<FormBuilderState>();

  /// Успешна ли валидация форма или нет
  final isFormValidNotifier = ValueNotifier(false);

  /// Колбэк изменения [isFormValid]
  void onFormChanged() => isFormValidNotifier.value = isCurrentFormValid;

  /// Успешна ли валидация текущих данных формы
  bool get isCurrentFormValid =>
      formKey.currentState?.fields.values.every((element) {
        return element.isValid;
      }) ??
      false;
}
