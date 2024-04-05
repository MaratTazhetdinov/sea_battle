import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sea_battle/firebase_options.dart';
import 'package:sea_battle/l10n/l10n.dart';
import 'package:sea_battle/parts/auth/auth_part.dart';
import 'package:sea_battle/parts/game_session/game_session_part.dart';
import 'package:sea_battle/parts/profile/profile_part.dart';
import 'package:sea_battle/parts/router/router_part.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _runApp();
}

void _runApp() {
  final authDataProvider =
      FirebaseAuthDataProvider(firebaseAuth: FirebaseAuth.instance);
  final profileDataProvider =
      FirestoreProfileDataProvider(db: FirebaseFirestore.instance);
  final gameSessionDataProvider =
      FbDbGameSessionDataProvider(db: FirebaseDatabase.instance);
  final appRouter = AppRouter();
  runApp(MyApp(
    iAuthDataProvider: authDataProvider,
    iProfileDataProvider: profileDataProvider,
    iGameSessionDataProvider: gameSessionDataProvider,
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final IAuthDataProvider iAuthDataProvider;
  final IProfileDataProvider iProfileDataProvider;
  final IGameSessionDataProvider iGameSessionDataProvider;
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.iAuthDataProvider,
    required this.iProfileDataProvider,
    required this.iGameSessionDataProvider,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IAuthRepository>(
          create: (context) =>
              AuthRepository(iAuthDataProvider: iAuthDataProvider),
        ),
        RepositoryProvider<IProfileRepository>(
          create: (context) =>
              ProfileRepository(iProfileDataProvider: iProfileDataProvider),
        ),
        RepositoryProvider<IGameSessionRepository>(
          create: (context) => GameSessionRepository(
              gameSessionDataProvider: iGameSessionDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              iAuthRepository: RepositoryProvider.of<IAuthRepository>(context),
              iProfileRepository:
                  RepositoryProvider.of<IProfileRepository>(context),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: appRouter.config(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          theme: AppTheme(colorScheme: AppColors.light()).theme,
        ),
      ),
    );
  }
}
