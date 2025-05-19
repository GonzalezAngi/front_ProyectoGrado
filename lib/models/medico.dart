import 'package:front_proyectogrado/models/especialidad.dart';
import 'package:front_proyectogrado/models/user.dart';

class Medico {
  final int id;
  final Especialidad especialidad;
  final User usuario;
  final String estado;
  final String tarjetaProfe;

  Medico({
    required this.id,
    required this.especialidad,
    required this.usuario,
    required this.estado,
    required this.tarjetaProfe,
  });

  //convierte un objeto JSON a un objeto Medico
  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      id: json['id'],
      especialidad: Especialidad.fromJson(json['especialidad']),
      usuario: User.fromJson(json['usuario']),
      estado: json['estado'],
      tarjetaProfe: json['tarjetaProfe'],
    );
  }

  //convierte un objeto Medico a un objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'especialidad': especialidad.toJson(),
      'usuario': usuario.toJson(),
      'estado': estado,
      'tarjetaProfe': tarjetaProfe,
    };
  }
}
