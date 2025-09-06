// lib/screens/search_location_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/location.dart';
import 'package:test_app/providers/rick_morty_provider.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final controller = TextEditingController();
  Location? location;

  void _search() async {
    final provider = Provider.of<RickMortyProvider>(context, listen: false);
    final id = int.tryParse(controller.text);
    if (id != null) {
      final result = await provider.getLocationById(id);
      setState(() {
        location = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Location")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter Location ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _search,
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),
            if (location != null)
              Card(
                child: ListTile(
                  title: Text(location!.name),
                  subtitle: Text("${location!.type} - ${location!.dimension}"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
