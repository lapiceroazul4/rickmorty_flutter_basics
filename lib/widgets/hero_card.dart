import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/heroe.dart';

class HeroCard extends StatelessWidget {
  final Heroe heroe;

  const HeroCard({super.key, required this.heroe});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            heroe.img,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.person),
          ),
        ),
        title: Text(heroe.nombre),
        subtitle: Text(heroe.casa),
        onTap: () => context.go('/heroe/${heroe.id}'),
      ),
    );
  }
}
