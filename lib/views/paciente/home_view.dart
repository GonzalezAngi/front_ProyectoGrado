import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.go('/'); // Regresa a la pantalla anterior
            },
          ),
          elevation: 2,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 40), // Baja el título "Bienvenido"
              const Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40), // Espaciado entre el título y el primer botón
              if (!_isKeyboardVisible)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para solicitar cita
                      Navigator.pushNamed(context, '/pedirCita');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Solicitar cita',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 20), // Espaciado entre botones
              if (!_isKeyboardVisible)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para ver citas pendientes
                      Navigator.pushNamed(context, '/citasPendientes');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Ver citas pendientes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 20), // Espaciado entre botones
              if (!_isKeyboardVisible)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para actualizar datos
                      Navigator.pushNamed(context, '/actualizarDatos');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Actualizar datos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}