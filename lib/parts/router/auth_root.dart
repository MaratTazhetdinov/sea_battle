part of 'router_part.dart';

@RoutePage()
class AuthScreenRoot extends StatelessWidget {
  const AuthScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return RootWrapper(
      widget: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.router.replace(const HomeRoute());
          }
        },
        child: const AutoRouter(),
      ),
    );
  }
}
