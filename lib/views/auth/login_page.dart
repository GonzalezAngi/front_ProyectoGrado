import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_proyectogrado/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedUserType;
  final _identificationCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    // Encripta la contraseña usando SHA-256
    // Genera el hash
    final bytes = utf8.encode(_contrasenaCtrl.text.trim());
    final hashedPassword = sha256.convert(bytes).toString();

    final result = await AuthService().login(
      _selectedUserType.toString(),
      hashedPassword,
      _identificationCtrl.text.trim(),
    );

    setState(() => isLoading = false);

    if (result['success']) {
      if (!mounted) return;
      if (_selectedUserType == 'Administrador') {
        context.go('/AdminPage');
      } else if (_selectedUserType == 'Paciente') {
        context.go('/home_view');
      } else {
        context.go('/especialidades');
      }
    } else {
      setState(() {
        errorMessage = result['message'] ?? 'Error al iniciar sesión';
      });

      // Muestra el mensaje de error en un SnackBar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage!)));
    }
  }

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
            child: Form(
              key: _formKey,
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
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 300, // Ancho máximo ajustado
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: _identificationCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Número de documento*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el número de documento';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300, // Ancho máximo ajustado
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Tipo de usuario*',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedUserType,
                        items: const [
                          DropdownMenuItem(
                            value: 'Paciente',
                            child: Text('Paciente'),
                          ),
                          DropdownMenuItem(
                            value: 'Medico',
                            child: Text('Médico'),
                          ),
                          DropdownMenuItem(
                            value: 'Administrador',
                            child: Text('Administrador'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor seleccione el tipo de usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300, // Ancho máximo ajustado
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        obscureText: true,
                        controller: _contrasenaCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 300, // Ancho máximo ajustado
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      child:
                          isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                'Iniciar sesión',
                                style: TextStyle(color: Colors.white),
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300, // Ancho máximo ajustado
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
