import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sea_battle/firebase_options.dart';
import 'package:sea_battle/l10n/l10n.dart';
import 'package:sea_battle/parts/auth/auth_part.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      theme: AppTheme(colorScheme: AppColors.light()).theme,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepoistory>(
            create: (context) => AuthRepository(
              authDataProvider: FirebaseDataProvider(
                firebaseAuth: FirebaseAuth.instance,
              ),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<IAuthRepoistory>(context),
              ),
            ),
          ],
          child: const AuthScreen(),
        ),
      ),
    );
  }
}
