import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_proyectogrado/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:crypto/crypto.dart'; // Para SHA-256

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final identificationCtrl = TextEditingController();
  final contrasenaCtrl = TextEditingController();
  String? _selectedDocumentType;
  String? _selectedGender;
  String? _selectedUserStatus;
  String? _selectedUserType;
  bool isLoading = false;
  String? errorMessage;

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

     // Encripta la contraseña usando SHA-256
    final bytes = utf8.encode(contrasenaCtrl.text.trim()); // Convierte la contraseña a bytes
    final hashedPassword = sha256.convert(bytes).toString(); // Genera el hash

    final result = await AuthService().register(
      nombreCtrl.text.trim(),
      telefonoCtrl.text.trim(),
      emailCtrl.text.trim(),
      identificationCtrl.text.trim(),
      _selectedGender.toString(),
      _selectedUserStatus.toString(),
      _selectedDocumentType.toString(),
      hashedPassword, // Envía la contraseña encriptada
      _selectedUserType.toString(),
    );

    setState(() => isLoading = false);

    if (result['success']) {
      if (!mounted) return;
      context.go('/');
    } else {
      setState(() {
        errorMessage = result['message'] ?? 'Error al registrarse';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Conecta el formulario al _formKey
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Registro Usuario',
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
                    width: 300,
                    child: TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre y apellido*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa tu nombre'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: telefonoCtrl,
                      decoration: InputDecoration(
                        labelText: 'Teléfono*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa tu teléfono'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        labelText: 'Email*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa tu email'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de documento*',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedDocumentType,
                      items: const [
                        DropdownMenuItem(
                          value: 'Cedula de ciudadania',
                          child: Text('Cédula de ciudadanía'),
                        ),
                        DropdownMenuItem(
                          value: 'Pasaporte',
                          child: Text('Pasaporte'),
                        ),
                        DropdownMenuItem(
                          value: 'Cedula de extranjeria',
                          child: Text('Cédula de extranjería'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDocumentType = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Selecciona un tipo de documento' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: identificationCtrl,
                      decoration: InputDecoration(
                        labelText: 'Número de documento*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa tu número de documento'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Género*',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedGender,
                      items: const [
                        DropdownMenuItem(
                          value: 'Masculino',
                          child: Text('Masculino'),
                        ),
                        DropdownMenuItem(
                          value: 'Femenino',
                          child: Text('Femenino'),
                        ),
                        DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Selecciona un género' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Estado Usuario*',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedUserStatus,
                      items: const [
                        DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                        DropdownMenuItem(
                          value: 'Inactivo',
                          child: Text('Inactivo'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedUserStatus = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Selecciona un estado' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
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
                        DropdownMenuItem(value: 'Medico', child: Text('Médico')),
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
                      validator: (value) =>
                          value == null ? 'Selecciona un tipo de usuario' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: contrasenaCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.length < 6
                              ? 'Mínimo 6 caracteres'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Vuelve a escribir la contraseña*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirma tu contraseña';
                        }
                        if (value != contrasenaCtrl.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          isLoading ? null : register, // Llama al método register
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Crear cuenta',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go('/login'), // Redirige al inicio de sesión
                    child: const Text('¿Ya tienes cuenta? Inicia sesión'),
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