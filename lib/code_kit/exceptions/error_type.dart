part of '../code_kit_part.dart';

enum ErrorType {
  wrongPassword,
  invalidLoginCredentials,
  invalidEmail,
  userDisabled,
  userNotFound,
  emailAlreadyInUse,
  operationNotAllowed,
  weakPassword,
  unexpectedError,
  nicknameAlreadyInUse,
}

ErrorType parseErrorType(Object error) {
  if (error is ErrorType) {
    return error;
  }
  try {
    return switch (error) {
      FirebaseAuthException authException
          when authException.code == 'wrong-password' =>
        ErrorType.wrongPassword,
      FirebaseAuthException authException
          when authException.code == "INVALID_LOGIN_CREDENTIALS" =>
        ErrorType.invalidLoginCredentials,
      FirebaseAuthException authException
          when authException.code == 'invalid-email' =>
        ErrorType.invalidEmail,
      FirebaseAuthException authException
          when authException.code == 'user-disabled' =>
        ErrorType.userDisabled,
      FirebaseAuthException authException
          when authException.code == 'user-not-found' =>
        ErrorType.userNotFound,
      FirebaseAuthException authException
          when authException.code == 'email-already-in-use' =>
        ErrorType.emailAlreadyInUse,
      FirebaseAuthException authException
          when authException.code == 'operation-not-allowed' =>
        ErrorType.operationNotAllowed,
      FirebaseAuthException authException
          when authException.code == 'weak-password' =>
        ErrorType.weakPassword,
      _ => ErrorType.unexpectedError,
    };
  } catch (e) {
    return ErrorType.unexpectedError;
  }
}

extension ErrorTypeLocalization on ErrorType {
  String toLocalizedMessage(AppLocalizations locale) {
    return switch (this) {
      ErrorType.wrongPassword ||
      ErrorType.invalidLoginCredentials =>
        locale.wrongPasswordError,
      ErrorType.invalidEmail => locale.invalidEmailError,
      ErrorType.userDisabled => locale.userDisabledError,
      ErrorType.userNotFound => locale.userNotFoundError,
      ErrorType.emailAlreadyInUse => locale.emailAlreadyInUseError,
      ErrorType.operationNotAllowed => locale.operationNotAllowedError,
      ErrorType.weakPassword => locale.weakPasswordError,
      ErrorType.unexpectedError => locale.unexpectedError,
      ErrorType.nicknameAlreadyInUse => locale.nicknameAlreadyInUseError,
    };
  }
}
