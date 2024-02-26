part of 'router_part.dart';

class RootWrapper extends StatelessWidget {
  final Widget widget;

  const RootWrapper({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          final message =
              parseErrorType(state.error).toLocalizedMessage(locale);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: widget,
    );
  }
}
