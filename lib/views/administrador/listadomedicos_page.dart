import 'package:flutter/material.dart';
import 'package:front_proyectogrado/models/medico.dart';
import 'package:front_proyectogrado/services/medico_service.dart';
import 'package:go_router/go_router.dart';

class ListadoMedicosPage extends StatefulWidget {
  const ListadoMedicosPage({super.key});

  @override
  State<ListadoMedicosPage> createState() => _ListadoMedicosPageState();
}

class _ListadoMedicosPageState extends State<ListadoMedicosPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final MedicoService _service = MedicoService();
  late Future<List<Medico>> _future;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _future = _service.getMedicos();
    // Inicializa el futuro para obtener médicos
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            context.go('/AdminPage');
          },
        ),
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: 'Todos'),
              Tab(text: 'Activos'),
              Tab(text: 'Inactivos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMedicosList(context, 'Todos'),
                _buildMedicosList(context, 'Activo'),
                _buildMedicosList(context, 'Inactivo'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicosList(BuildContext context, String status) {
    return FutureBuilder<List<Medico>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay médicos disponibles.'));
        } else {
          final medicos = snapshot.data!;
          final filteredMedicos =
              status == 'Todos'
                  ? medicos
                  : medicos.where((medico) => medico.estado == status).toList();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: filteredMedicos.length,
            itemBuilder: (context, index) {
              final medico = filteredMedicos[index];
              return SizedBox(
                width:
                    300, // Ancho ajustado para coincidir con login y registro
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      medico.usuario.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(medico.especialidad.nombre),
                        Text(medico.usuario.identificacion),
                        Text(medico.tarjetaProfe),
                      ],
                    ),
                    trailing: Icon(
                      medico.estado == 'Activo'
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color:
                          medico.estado == 'Activo' ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
