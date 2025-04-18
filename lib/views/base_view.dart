import 'package:flutter/material.dart';
// Importa el Drawer personalizado

class BaseView extends StatelessWidget {
  final String title;
  final Widget body;

  const BaseView({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // Drawer persistente para todas las vistas
      body: body,
    );
  }
}
