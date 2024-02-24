part of '../auth_part.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository iAuthRepository;
  final IProfileRepository iProfileRepository;
  StreamSubscription<UserModel>? _userSubscription;

  AuthBloc({
    required this.iAuthRepository,
    required this.iProfileRepository,
  }) : super(const AuthInitial()) {
    _userSubscription = iAuthRepository.user
        .listen((user) => add(_AuthUserChanged(user: user)));

    on<_AuthUserChanged>(_onUserChanged);
    on<AuthSignedUpByEmailAndPassword>(_onSignedUpByEmailAndPassword);
    on<AuthSignedInByEmailAndPassword>(_onSignedInByEmailAndPassword);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onUserChanged(
      _AuthUserChanged event, Emitter<AuthState> emit) async {
    try {
      UserModel user = event.user;

      if (user.isNotEmpty) {
        final profile =
            await iProfileRepository.getProfileById(id: event.user.id);
        if (profile case final profile?) {
          user = UserModel.fromProfile(profile: profile);
        } else {
          throw ErrorType.unexpectedError;
        }
      }
      emit(AuthState(
        status: user.isEmpty
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(AuthError(
        error: e,
        status: state.status,
        user: state.user,
      ));
    }
  }

  Future<void> _onSignedUpByEmailAndPassword(
      AuthSignedUpByEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading(status: state.status, user: state.user));
    try {
      final isNicknameInUse =
          await iProfileRepository.isNicknameInUse(nickname: event.nickname);
      if (isNicknameInUse) {
        throw ErrorType.nicknameAlreadyInUse;
      }
      final userId = await iAuthRepository.signUpByEmailAndPassword(
          email: event.email, password: event.password);
      if (userId case final id?) {
        await iProfileRepository.createProfile(
            profile: Profile(
          id: id,
          email: event.email,
          nickname: event.nickname,
        ));
      } else {
        throw ErrorType.unexpectedError;
      }
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
      await iAuthRepository.signInByEmailAndPassword(
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
      await iAuthRepository.signOut();
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
