import 'package:flutter/material.dart';

class Listview1Screen extends StatelessWidget {
  final options = const [
    'Megaman',
    'Metal Gear',
    'Super Smash',
    'Final Fantasy',
  ];

  const Listview1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View 1'), 
        centerTitle: true),
      body: ListView(
        children: [
          ...options.map(
            (juego) => ListTile(
              leading: Icon(Icons.access_alarm),
              tileColor: Color.fromARGB(255, 241, 241, 241),
              title: Text(juego),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
