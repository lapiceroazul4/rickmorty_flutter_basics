import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heroes_provider.dart';
import '../models/multimedia.dart';
import '../widgets/gallery_grid.dart';

class MultimediaScreen extends StatelessWidget {
  static const String name = 'multimedia_screen';
  final String heroeId;

  const MultimediaScreen({super.key, required this.heroeId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HeroesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Galería del Héroe"),
      ),
      body: FutureBuilder<List<Multimedia>>(
        future: provider.getMultimediaByHeroe(heroeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text("Este héroe no tiene multimedia asociada"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GalleryGrid(items: items),
          );
        },
      ),
    );
  }
}
