part of '../code_kit_part.dart';

/// Validators for user's inputs
class AppTextValidators {
  /// Check if field is not empty
  static FormFieldValidator<String> emptyStringValidator(
    AppLocalizations locale,
  ) =>
      FormBuilderValidators.required(errorText: locale.emptyFieldError);

  /// Check if email is valid
  static FormFieldValidator<String> emailValidator(AppLocalizations locale) =>
      (value) => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value ?? '')
          ? null
          : locale.invalidEmail;

  /// Check if nickname is valid
  static FormFieldValidator<String> nicknameValidator(
          AppLocalizations locale) =>
      (value) => RegExp(r'^[a-zA-Z0-9]{6,}$').hasMatch(value ?? '')
          ? null
          : locale.invalidNickName;

  /// Check if password is valid
  static FormFieldValidator<String> passwordValidator(
          AppLocalizations locale) =>
      (value) =>
          RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                  .hasMatch(value ?? '')
              ? null
              : locale.invalidPassword;

  /// Check if second password is equal to the first one
  static FormFieldValidator<String> secondPasswordValidator(
          AppLocalizations locale, String firstPassword) =>
      (value) =>
          (value ?? '') == firstPassword ? null : locale.invalidSecondPassword;
}
