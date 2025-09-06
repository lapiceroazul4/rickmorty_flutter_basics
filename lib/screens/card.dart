import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/character.dart';
import 'package:test_app/providers/rick_morty_provider.dart';
import 'package:test_app/widgets/widgets.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final provider = Provider.of<RickMortyProvider>(context, listen: false);

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.getOnDisplayCharacters(); // 🔥 carga más
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rickMortyProvider = Provider.of<RickMortyProvider>(context);
    final List<Character> characters = rickMortyProvider.characters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick & Morty Characters'),
        centerTitle: true,
      ),
      body: characters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: characters.length + 1, // +1 para el loader al final
              itemBuilder: (context, index) {
                if (index < characters.length) {
                  final character = characters[index];
                  return Column(
                    children: [
                      CustomCardType2(
                        name: '${character.name} (${character.status})',
                        imageUrl: character.image,
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                } else {
                  // loader mientras carga más
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
    );
  }
}
