part of '../home_part.dart';

@RoutePage()
class BootScreen extends StatelessWidget {
  const BootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          switch (state.status) {
            case AuthStatus.authenticated:
              context.router.replace(const HomeRoute());
            case AuthStatus.unauthenticated:
              context.router.replace(const AuthRoute());
          }
        },
        child: const AppLoader(),
      ),
    );
  }
}
