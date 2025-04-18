import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:front_proyectogrado/models/especialidad.dart';

class EspecialidadServices {
  //! se inicializa dotenv para cargar las variables de entorno
  final String baseUrl = dotenv.env['URL_API']!;

  //! getEstablecimientos
  /// Obtiene una lista de establecimientos desde la API.
Future<List<Especialidad>> getEspecialidades() async {
  final response = await http.get(Uri.parse('${baseUrl}especialidad'));
  if (response.statusCode == 200) {
    // Decodifica la respuesta JSON directamente como una lista
    final List<dynamic> data = jsonDecode(response.body);

    // Convierte cada elemento de la lista en un objeto Especialidad
    return data.map((item) => Especialidad.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar especialidades: ${response.statusCode}');
  }
}

  //! getEstablecimiento
  /// Obtiene un establecimiento específico por su ID desde la API.
  /// Devuelve un objeto Establecimiento.
Future<Especialidad> getEspecialidad(int id) async {
  final response = await http.get(Uri.parse('${baseUrl}especialidad/$id'));

  if (response.statusCode == 200) {
    // Decodifica la respuesta JSON
    final json = jsonDecode(response.body);

    // Convierte el JSON en un objeto Especialidad
    return Especialidad.fromJson(json);
  } else {
    // Lanza una excepción si el código de estado no es 200
    throw Exception('Error al obtener la especialidad: ${response.statusCode}');
  }
}

  //!updateEstablecimiento
  /// Actualiza un establecimiento en la API.
  /// Recibe un objeto Establecimiento y un archivo de imagen opcional.
  /// Devuelve true si la actualización fue exitosa, false en caso contrario.
  Future<bool> updateEspecialidad(Especialidad est) async {
    try {
      final uri = Uri.parse('${baseUrl}especialidad');

      // Codificar imagen como base64 si existe
      // se codifica la imagen a base64 porque la API lo requiere
      // base 64 se usa para convertir datos binarios a texto
      // y se puede enviar como un string en JSON

      final body = jsonEncode(est.toJson());

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar establecimiento: $e');
    }
  }

  //! createEstablecimiento
  /// Crea un nuevo establecimiento en la API.
  /// Recibe un objeto Establecimiento y un archivo de imagen opcional.
  /// Devuelve true si la creación fue exitosa, false en caso contrario.
  Future<bool> createEspecialidad(Especialidad est) async {
  try {
    final uri = Uri.parse('${baseUrl}especialidad');

    // Genera el cuerpo de la solicitud sin incluir el campo 'id'
    final body = jsonEncode({
      'nombre': est.nombre,
      'estado': est.estado,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    // Verifica si el código de estado indica éxito
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true; // La creación fue exitosa
    } else {
      // Si el código de estado no es exitoso, lanza una excepción
      throw Exception('Error al crear especialidad: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error al crear especialidad: $e');
  }
}
  //! deleteEstablecimiento
  /// Realiza un borrado lógico de un establecimiento por ID.
  /// Retorna true si fue exitoso.

 Future<bool> deleteEspecialidad(int id) async {
  final response = await http.delete(Uri.parse('${baseUrl}especialidad/$id'));

  if (response.statusCode == 200) {
    // Verifica si la respuesta contiene el texto esperado
    if (response.body.contains('eliminada exitosamente')) {
      return true; // La eliminación fue exitosa
    } else {
      // Si no contiene el texto esperado, lanza una excepción
      throw Exception('Respuesta inesperada: ${response.body}');
    }
  } else {
    // Si el código de estado no es 200, lanza una excepción
    throw Exception('Error al eliminar la especialidad: ${response.statusCode}');
  }
}
  
  }
