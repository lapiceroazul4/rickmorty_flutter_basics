import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/router/app_router.dart';
import 'package:test_app/theme/app_theme.dart';
import 'package:test_app/providers/rick_morty_provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RickMortyProvider(),
          lazy: false, // se inicializa de inmediato
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Flutter App',
      debugShowCheckedModeBanner: false,

      //Ruta inicial
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.getAppRoutes(),
      theme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
