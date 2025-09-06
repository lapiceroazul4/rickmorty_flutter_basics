// lib/screens/locations_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/rick_morty_provider.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<RickMortyProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.getOnDisplayLocations();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RickMortyProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Locations")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: provider.locations.length,
        itemBuilder: (context, index) {
          final location = provider.locations[index];
          return ListTile(
            leading: const Icon(Icons.place),
            title: Text(location.name),
            subtitle: Text("${location.type} - ${location.dimension}"),
          );
        },
      ),
    );
  }
}
