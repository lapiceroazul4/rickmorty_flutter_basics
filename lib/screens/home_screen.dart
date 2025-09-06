import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/heroes');
              },
              icon: const Icon(Icons.people),
              label: const Text("Ver Héroes"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/multimedias');
              },
              icon: const Icon(Icons.photo_library),
              label: const Text("Ver Multimedias"),
            ),
          ],
        ),
      ),
    );
  }
}
