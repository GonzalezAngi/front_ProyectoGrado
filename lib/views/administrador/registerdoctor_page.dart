import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({super.key});

  @override
  State<RegisterDoctorPage> createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  final _identificationCtrl = TextEditingController();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _numeroDocumentoController = TextEditingController();
  final _tarjetaProfesionalController = TextEditingController();

  String? _selectedDocumentType;
  String? _selectedGender;
  String? _selectedUserStatus;
  String? _selectedSpecialty;
  String? _selectedDoctorStatus;

  //! Método para buscar un médico por identificación
  Future<void> _buscarPorIdentificacion() async {
    final identificacion = _identificationCtrl.text.trim();

    if (identificacion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese una identificación')),
      );
      return;
    }

    try {
      // Realiza la llamada a la API
      final response = await http.get(
        Uri.parse('http://18.224.34.150:8080/usuario'),
      );

      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final datos = jsonDecode(response.body);

        // Precarga los datos en los campos del formulario
        setState(() {
          _nombreController.text = datos['nombre'] ?? '';
          _telefonoController.text = datos['telefono'] ?? '';
          _emailController.text = datos['email'] ?? '';
          _numeroDocumentoController.text = datos['numeroDocumento'] ?? '';
          _tarjetaProfesionalController.text = datos['tarjetaProfesional'] ?? '';
          _selectedDocumentType = datos['tipoDocumento'];
          _selectedGender = datos['genero'];
          _selectedUserStatus = datos['estadoUsuario'];
          _selectedSpecialty = datos['especialidad'];
          _selectedDoctorStatus = datos['estadoMedico'];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos cargados correctamente')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró un médico con esa identificación')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al buscar los datos')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
        title: const Text(
          'Registrar Médico',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _identificationCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Buscar por Identificación',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _buscarPorIdentificacion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Buscar',
                        style: TextStyle(color: Colors.white),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre y apellido*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el nombre y apellido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Teléfono*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el teléfono';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el email';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione el tipo de documento';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione el género';
                        }
                        return null;
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione el estado del usuario';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Especialidad*',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedSpecialty,
                      items: const [
                        DropdownMenuItem(
                          value: 'Cardiología',
                          child: Text('Cardiología'),
                        ),
                        DropdownMenuItem(
                          value: 'Pediatría',
                          child: Text('Pediatría'),
                        ),
                        DropdownMenuItem(
                          value: 'Dermatología',
                          child: Text('Dermatología'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedSpecialty = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione la especialidad';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Estado Médico*',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedDoctorStatus,
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
                          _selectedDoctorStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione el estado del médico';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Número de tarjeta profesional*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el número de tarjeta profesional';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Acción para guardar el registro
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Guardar',
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