part of '../auth_part.dart';

class SignInWidget extends StatefulWidget {
  final ValueNotifier<AuthMethod> selectedAuthMethodNotifier;
  const SignInWidget({
    super.key,
    required this.selectedAuthMethodNotifier,
  });

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends FormValidationState<SignInWidget> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _emailName = 'email';
  final _passwordName = 'password';

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
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
              locale.signInToAnAccount,
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
            title: locale.password,
            textInputField: TextInputField(
              name: _passwordName,
              validator: FormBuilderValidators.compose([
                AppTextValidators.emptyStringValidator(locale),
                AppTextValidators.nicknameValidator(locale)
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordTextController,
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
                              .add(AuthSignedInByEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          ))
                      : null,
                  child: Text(locale.signIn),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                text: '${locale.doNotHaveAnAccount} ',
                style: theme.textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: locale.signUpInstead,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colors.secondTextColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => widget.selectedAuthMethodNotifier.value =
                          AuthMethod.signUp,
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
