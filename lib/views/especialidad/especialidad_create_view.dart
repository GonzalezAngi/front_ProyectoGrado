import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_proyectogrado/models/especialidad.dart';
import 'package:front_proyectogrado/services/especialidad_serives.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EspecialidadCreateView extends StatefulWidget {
  const EspecialidadCreateView({super.key});

  @override
  State<EspecialidadCreateView> createState() => _EspecialidadCreateViewState();
}

class _EspecialidadCreateViewState extends State<EspecialidadCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _service = EspecialidadServices();

  late TextEditingController _nombreController;
  late TextEditingController _estadoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _estadoController = TextEditingController();
  }

  //! pickImage se utiliza para seleccionar una imagen de la galería

  //! submit se utiliza para enviar los datos del formulario
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final est = Especialidad(
        nombre: _nombreController.text,
        estado: 'Activo',
      );

      final ok = await _service.createEspecialidad(est);

      if (!mounted) return;

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Especialidad creada correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear especialidad')),
        );
      }
      if (Navigator.of(context).canPop()) {
        context.pop(true);
      } else {
        context.go('/AdminPage'); // O navega a donde quieras
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Especialidad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/AdminPage'); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Crear Especialidad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
