import 'package:flutter/material.dart';

class ListadoMedicosPage extends StatefulWidget {
  const ListadoMedicosPage({super.key});

  @override
  State<ListadoMedicosPage> createState() => _ListadoMedicosPageState();
}

class _ListadoMedicosPageState extends State<ListadoMedicosPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                _buildMedicosList(context, 'Activos'),
                _buildMedicosList(context, 'Inactivos'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicosList(BuildContext context, String status) {
    // Ejemplo de datos de médicos
    final List<Map<String, String>> medicos = [
      {
        'nombre': 'Dr. Juan Pérez',
        'especialidad': 'Cardiología',
        'estado': 'Activo',
      },
      {
        'nombre': 'Dra. Ana López',
        'especialidad': 'Pediatría',
        'estado': 'Inactivo',
      },
      {
        'nombre': 'Dr. Carlos Gómez',
        'especialidad': 'Dermatología',
        'estado': 'Activo',
      },
    ];

    // Filtrar médicos según el estado
    final filteredMedicos = status == 'Todos'
        ? medicos
        : medicos.where((medico) => medico['estado'] == status).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filteredMedicos.length,
      itemBuilder: (context, index) {
        final medico = filteredMedicos[index];
        return SizedBox(
          width: 300, // Ancho ajustado para coincidir con login y registro
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                medico['nombre']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(medico['especialidad']!),
              trailing: Icon(
                medico['estado'] == 'Activo'
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: medico['estado'] == 'Activo' ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}