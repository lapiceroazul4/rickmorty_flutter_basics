import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  void _showAlert(BuildContext context) {
    showDialog(
      barrierDismissible: false, // Para obligar a presionar un botón
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text(
          'Este es el contenido de la alerta.\n¿Quieres continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert'), 
        centerTitle: true,
        backgroundColor: Colors.red),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showAlert(context),
          child: const Text('Mostrar alerta'),
        ),
      ),
    );
  }
}
