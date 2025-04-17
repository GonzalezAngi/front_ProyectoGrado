import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Inicio de sesión',
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '¡Por favor complete todos los campos!',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 60,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Tipo de documento*'),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 350,
                  height: 60,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Número de documento*'),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 350,
                  height: 60,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Tipo de usuario*'),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 350,
                  height: 60,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Contraseña*'),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 350,
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 350,
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}