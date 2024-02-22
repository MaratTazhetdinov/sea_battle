part of '../auth_part.dart';

enum AuthMethod { signUp, signIn }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _selectedAuthMethodNotifier =
      ValueNotifier<AuthMethod>(AuthMethod.signUp);

  @override
  void dispose() {
    _selectedAuthMethodNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(parseErrorType(state.error)
                          .toLocalizedMessage(context.l10n))));
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.user.email ?? 'EmptyEmail'),
                        ElevatedButton(
                          onPressed: () {
                            context.readAuthBloc.add(AuthLoggedOut());
                          },
                          child: const Text('LogOut'),
                        ),
                      ],
                    );
                  } else {
                    return ValueListenableBuilder(
                      valueListenable: _selectedAuthMethodNotifier,
                      builder: (context, value, _) {
                        return AnimatedSwitcher(
                          duration: const Duration(
                              milliseconds:
                                  defaultAnimationDurationInMilliseconds),
                          child: switch (value) {
                            AuthMethod.signUp => SignUpWidget(
                                selectedAuthMethodNotifier:
                                    _selectedAuthMethodNotifier,
                              ),
                            AuthMethod.signIn => SignInWidget(
                                selectedAuthMethodNotifier:
                                    _selectedAuthMethodNotifier),
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
