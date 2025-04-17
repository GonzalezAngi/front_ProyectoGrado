import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedDocumentType;
  String? _selectedGender;
  String? _selectedUserStatus;
  String? _selectedUserType;

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
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre y apellido*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Teléfono*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email*',
                      border: OutlineInputBorder(),
                    ),
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
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Número de documento*',
                      border: OutlineInputBorder(),
                    ),
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
                      DropdownMenuItem(
                        value: 'Otro',
                        child: Text('Otro'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
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
                      DropdownMenuItem(
                        value: 'Activo',
                        child: Text('Activo'),
                      ),
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
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Vuelve a escribir la contraseña*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para crear cuenta (vacío por ahora)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Crear cuenta',
                      style: TextStyle(color: Colors.white),
                    ),
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