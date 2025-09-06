import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/heroes_provider.dart';
import 'screens/screens.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeroesProvider()),
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
      debugShowCheckedModeBanner: false,
      title: 'App de Héroes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/heroes': (_) => const HeroesScreen(),
        '/multimedias': (_) => const MultimediasScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/hero/')) {
          final uri = Uri.parse(settings.name!);
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => HeroDetailScreen(id: id),
          );
        }
        if (settings.name!.startsWith('/hero/') &&
            settings.name!.endsWith('/multimedia')) {
          final uri = Uri.parse(settings.name!);
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => MultimediaScreen(heroeId: id),
          );
        }
        return null;
      },
    );
  }
}
