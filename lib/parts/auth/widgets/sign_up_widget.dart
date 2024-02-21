part of '../auth_part.dart';

class SignUpWidget extends StatefulWidget {
  final ValueNotifier<AuthMethod> selectedAuthMethodNotifier;

  const SignUpWidget({
    super.key,
    required this.selectedAuthMethodNotifier,
  });

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends FormValidationState<SignUpWidget> {
  final _emailTextController = TextEditingController();
  final _nicknameTextController = TextEditingController();
  final _firstPasswordTextController = TextEditingController();
  final _secondPasswordTextController = TextEditingController();
  final _emailName = 'email';
  final _nicknameName = 'nickname';
  final _firstPasswordName = 'first_password';
  final _secondPasswordName = 'second_password';

  @override
  void dispose() {
    _emailTextController.dispose();
    _nicknameTextController.dispose();
    _firstPasswordTextController.dispose();
    _secondPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    final theme = context.theme;
    return FormBuilder(
      key: formKey,
      onChanged: onFormChanged,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            child: Text(
              locale.createAccount,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          HeaderTextInputField(
            title: locale.email,
            textInputField: TextInputField(
              name: _emailName,
              validator: FormBuilderValidators.compose([
                AppTextValidators.emptyStringValidator(locale),
                AppTextValidators.emailValidator(locale)
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextController,
              textInputAction: TextInputAction.next,
            ),
          ),
          HeaderTextInputField(
            title: locale.nickname,
            textInputField: TextInputField(
              name: _nicknameName,
              validator: FormBuilderValidators.compose([
                AppTextValidators.emptyStringValidator(locale),
                AppTextValidators.nicknameValidator(locale)
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              controller: _nicknameTextController,
              textInputAction: TextInputAction.next,
            ),
          ),
          HeaderTextInputField(
            title: locale.password,
            textInputField: TextInputField(
              name: _firstPasswordName,
              validator: FormBuilderValidators.compose([
                AppTextValidators.emptyStringValidator(locale),
                AppTextValidators.nicknameValidator(locale)
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _firstPasswordTextController,
              textInputAction: TextInputAction.next,
            ),
          ),
          HeaderTextInputField(
            title: locale.repeatPassword,
            textInputField: TextInputField(
              name: _secondPasswordName,
              validator: FormBuilderValidators.compose([
                AppTextValidators.emptyStringValidator(locale),
                AppTextValidators.nicknameValidator(locale)
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _secondPasswordTextController,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            child: ValueListenableBuilder(
              valueListenable: isFormValidNotifier,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value
                      ? () => context.readAuthBloc
                              .add(AuthSignedUpByEmailAndPassword(
                            email: _emailTextController.text,
                            password: _firstPasswordTextController.text,
                          ))
                      : null,
                  child: Text(locale.signUp),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                text: '${locale.alreadyHaveAnAccount} ',
                style: theme.textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: locale.signInInstead,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colors.secondTextColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => widget.selectedAuthMethodNotifier.value =
                          AuthMethod.signIn,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
