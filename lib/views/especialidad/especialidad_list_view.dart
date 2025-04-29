import 'package:flutter/material.dart';
import 'package:front_proyectogrado/models/especialidad.dart';
import 'package:front_proyectogrado/services/especialidad_serives.dart';
import 'package:front_proyectogrado/views/base_view.dart';
import 'package:front_proyectogrado/views/especialidad/especialidad_eliminar_view.dart';
import 'package:go_router/go_router.dart';

class EspecialidadesListView extends StatefulWidget {
  const EspecialidadesListView({super.key});

  @override
  EspecialidadesListViewState createState() => EspecialidadesListViewState();
}

class EspecialidadesListViewState extends State<EspecialidadesListView> {
  final EspecialidadServices _service = EspecialidadServices();
  late Future<List<Especialidad>> _future;

  @override
  void initState() {
    super.initState();
    //! Se inicializa el futuro para obtener los establecimientos
    _future = _service.getEspecialidades();
  }

  //! método para navegar a la vista de editar establecimiento
  //! Recibe el id del establecimiento a editar
 Future<void> _goToEdit(int id) async {
  final result = await context.push('/especialidades/edit/$id');

  //! Si el resultado es true, significa que se actualizó algo
  //! y se recarga la lista de especialidades
  if (result == true) {
    setState(() {
      _future = _service.getEspecialidades(); // Recarga toda la lista
    });
  }
}

  //! método para navegar a la vista de crear nuevo establecimiento
  Future<void> _goToCreate() async {
    final result = await context.push('/especialidades/create');

    //! Si se creó correctamente, se recarga la lista
    if (result == true) {
      setState(() {
        _future = _service.getEspecialidades();
      });
    }
  }

  //! Confirmación para eliminar establecimiento
  Future<void> _confirmDelete(int id) async {
    try {
      final ok = await _service.deleteEspecialidad(id);
      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Establecimiento eliminado correctamente'),
          ),
        );
        setState(() {
          _future = _service.getEspecialidades();
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No se pudo eliminar')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialidades'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Flecha para retroceder
          onPressed: () {
            context.go('/admin'); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: FutureBuilder<List<Especialidad>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay establecimientos disponibles'),
            );
          }

          final Especialidades = snapshot.data!;

          return ListView.builder(
            itemCount: Especialidades.length + 1, // +1 para el botón de crear
            itemBuilder: (context, index) {
              //! Primer ítem será el botón de crear
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _goToCreate,
                    icon: const Icon(Icons.add),
                    label: const Text('Crear nuevo especialidsta'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              }

              //! índice real de la lista (descontando el botón de crear)
              final especialidad = Especialidades[index - 1];

              return GestureDetector(
                onTap: () {
                  if (especialidad.id != null) {
                    _goToEdit(especialidad.id!);
                  }
                },
                onLongPress: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => const EspecialidadEliminarView(
                          title: '¿Eliminar establecimiento?',
                          message:
                              '¿Estás seguro que deseas eliminar este establecimiento?',
                        ),
                  );

                  if (confirm == true) {
                    if (especialidad.id != null) {
                      await _confirmDelete(especialidad.id!);
                    }
                  }
                },
                child: Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! Se muestra el logo si está disponible
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                especialidad.nombre,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Estado: ${especialidad.estado}'),
                              Text('Id: ${especialidad.id}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
