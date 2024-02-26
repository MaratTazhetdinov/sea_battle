part of 'router_part.dart';

@RoutePage()
class HomeScreenRoot extends StatelessWidget {
  const HomeScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return RootWrapper(
      widget: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            context.router.replace(const AuthRoute());
          }
        },
        child: const AutoRouter(),
      ),
    );
  }
}
