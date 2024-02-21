part of '../auth_part.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepoistory authRepository;
  StreamSubscription<UserModel>? _userSubscription;

  AuthBloc({
    required this.authRepository,
  }) : super(const AuthInitial()) {
    _userSubscription =
        authRepository.user.listen((user) => add(_AuthUserChanged(user: user)));

    on<_AuthUserChanged>(_onUserChanged);
    on<AuthSignedUpByEmailAndPassword>(_onSignedUpByEmailAndPassword);
    on<AuthSignedInByEmailAndPassword>(_onSignedInByEmailAndPassword);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onUserChanged(
      _AuthUserChanged event, Emitter<AuthState> emit) async {
    emit(AuthState(
      status: event.user.isEmpty
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated,
      user: event.user,
    ));
  }

  Future<void> _onSignedUpByEmailAndPassword(
      AuthSignedUpByEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading(status: state.status, user: state.user));
    try {
      await authRepository.signUpByEmailAndPassword(
          email: event.email, password: event.password);
    } catch (e) {
      emit(AuthError(
        error: e,
        status: state.status,
        user: state.user,
      ));
    }
  }

  Future<void> _onSignedInByEmailAndPassword(
      AuthSignedInByEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading(status: state.status, user: state.user));
    try {
      await authRepository.signInByEmailAndPassword(
          email: event.email, password: event.password);
    } catch (e) {
      emit(AuthError(
        error: e,
        status: state.status,
        user: state.user,
      ));
    }
  }

  Future<void> _onLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading(status: state.status, user: state.user));
    try {
      await authRepository.signOut();
    } catch (e) {
      emit(AuthError(
        error: e,
        status: state.status,
        user: state.user,
      ));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

/// Context extension for quick access to [AuthBloc].
extension AuthBlocBuildContextX on BuildContext {
  /// Instance of [AuthBloc].
  AuthBloc get readAuthBloc => read<AuthBloc>();
}
