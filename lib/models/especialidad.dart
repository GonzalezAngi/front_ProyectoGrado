class Especialidad {
  final int? id; // Cambiado a nullable
  final String nombre;
  final String estado;

  Especialidad({
    this.id, // Ahora es opcional
    required this.nombre,
    required this.estado,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
      id: json['id'],
      nombre: json['nombre'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'nombre': nombre,
      'estado': estado,
    };

    if (id != null) {
      data['id'] = id.toString(); // Solo agregar id si no es null
    }

    return data;
  }
}