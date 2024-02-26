part of '../auth_part.dart';

enum AuthMethod { signUp, signIn }

@RoutePage()
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
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Center(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder(
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
