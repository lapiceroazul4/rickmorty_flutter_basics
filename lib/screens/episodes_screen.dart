// lib/screens/episodes_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/rick_morty_provider.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<RickMortyProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.getOnDisplayEpisodes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RickMortyProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Episodes")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: provider.episodes.length,
        itemBuilder: (context, index) {
          final episode = provider.episodes[index];
          return ListTile(
            leading: const Icon(Icons.movie),
            title: Text(episode.name),
            subtitle: Text("${episode.episode} - ${episode.airDate}"),
          );
        },
      ),
    );
  }
}
