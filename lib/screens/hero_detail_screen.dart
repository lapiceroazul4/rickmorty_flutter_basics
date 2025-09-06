import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/heroes_provider.dart';
import 'package:test_app/models/heroe.dart';
import 'package:test_app/models/multimedia.dart';
import 'package:test_app/widgets/gallery_grid.dart';

class HeroDetailScreen extends StatelessWidget {
  static const String name = 'hero_detail';
  final String id;

  const HeroDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HeroesProvider>(context, listen: false);

    return FutureBuilder<Heroe?>(
      future: provider.getHeroeById(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final heroe = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text(heroe.nombre)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen principal
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      heroe.img,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 100),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Biografía
                Text(
                  heroe.bio,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Galería de multimedia",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Cargar multimedia adicional
                FutureBuilder<List<Multimedia>>(
                  future: provider.getMultimediaByHeroe(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }

                    final items = snapshot.data ?? [];

                    if (items.isEmpty) {
                      return const Text(
                          "Este héroe no tiene multimedia adicional");
                    }

                    return GalleryGrid(items: items);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
