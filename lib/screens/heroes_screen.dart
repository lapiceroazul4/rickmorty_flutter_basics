import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/heroe.dart';
import 'package:test_app/providers/heroes_provider.dart';

class HeroesScreen extends StatelessWidget {
  static const String name = 'heroes';

  const HeroesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HeroesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Héroes"),
      ),
      body: FutureBuilder<List<Heroe>>(
        future: provider.getHeroes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final heroes = snapshot.data ?? [];

          if (heroes.isEmpty) {
            return const Center(
              child: Text("No hay héroes disponibles"),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: heroes.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final heroe = heroes[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(heroe.img),
                  onBackgroundImageError: (_, __) =>
                      const Icon(Icons.person),
                ),
                title: Text(heroe.nombre),
                subtitle: Text(heroe.casa),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/hero/${heroe.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
