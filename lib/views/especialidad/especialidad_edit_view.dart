import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_proyectogrado/models/especialidad.dart';
import 'package:front_proyectogrado/services/especialidad_serives.dart';
import 'package:go_router/go_router.dart';



class EspecialidadEditView extends StatefulWidget {
  final int id;

  const EspecialidadEditView({super.key, required this.id});

  @override
  State<EspecialidadEditView> createState() => _EspecialidadEditViewState();
}

class _EspecialidadEditViewState extends State<EspecialidadEditView> {
  final _formKey = GlobalKey<FormState>();
  final _service = EspecialidadServices();

  late TextEditingController _nombreController;
  late TextEditingController _estadoController;

  bool _isLoading = true; // Indicador de carga

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(); // Inicialización temprana
    _estadoController = TextEditingController(); // Inicialización temprana
    _loadEstablecimiento();
  }

  Future<void> _loadEstablecimiento() async {
    try {
      final est = await _service.getEspecialidad(widget.id);
      if (!mounted) return;

      setState(() {
        _nombreController.text = est.nombre;
        _estadoController.text = est.estado;
        _isLoading = false; // Finaliza la carga
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error cargando datos')),
      );
      context.pop();
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final est = Especialidad(
        id: widget.id,
        nombre: _nombreController.text,
        estado: 'A',
      );

      final ok = await _service.updateEspecialidad(est);

      if (!mounted) return;

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Especialidad actualizada')),
        );
        context.pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error actualizando')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Muestra un indicador de carga mientras se obtienen los datos
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Especialidad')),
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
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Libera los controladores al salir del widget
    _nombreController.dispose();
    _estadoController.dispose();
    super.dispose();
  }
}
