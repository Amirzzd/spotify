import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/config/app_theme.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_cubit.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_state.dart';
import 'package:spotify/features/song_player/bloc/song_player_bloc.dart';
import 'package:spotify/features/splash/presentation/screen/splash.dart';
import 'package:spotify/locator.dart';

import 'features/home/presentation/bloc/bottom nav/bottom_nav_cubit.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(),),
          BlocProvider(lazy: false,create: (context) => BottomNavCubit(),),
          BlocProvider(create: (_) => ThemeCubit(locator()),),
          BlocProvider(create: (_) => SongPlayerBloc(),)
        ],
        child: BlocBuilder<ThemeCubit,ThemeState>(
          builder: (BuildContext context, ThemeState state) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.currentTheme! ? ThemeMode.light : ThemeMode.dark ,
              // themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          },
        ),
    );
  }
}
