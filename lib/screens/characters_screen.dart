// lib/screens/characters_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/rick_morty_provider.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<RickMortyProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.getOnDisplayCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RickMortyProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Characters")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: provider.characters.length,
        itemBuilder: (context, index) {
          final character = provider.characters[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.image),
            ),
            title: Text(character.name),
            subtitle: Text(character.species),
          );
        },
      ),
    );
  }
}
