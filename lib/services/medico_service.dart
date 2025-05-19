import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_proyectogrado/models/medico.dart';
import 'package:http/http.dart' as http;

class MedicoService {
  //! se inicializa dotenv para cargar las variables de entorno
  final String baseUrl = dotenv.env['URL_API']!;

  //! getEstablecimientos
  /// Obtiene una lista de establecimientos desde la API.
  Future<List<Medico>> getMedicos() async {
    final response = await http.get(Uri.parse('${baseUrl}medico'));
    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON directamente como una lista
      final List<dynamic> data = jsonDecode(response.body);

      // Convierte cada elemento de la lista en un objeto Especialidad
      return data.map((item) => Medico.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar medicos: ${response.statusCode}');
    }
  }

  Future<Medico> getMedico(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}medico/$id'));

    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON
      final json = jsonDecode(response.body);

      // Convierte el JSON en un objeto Especialidad
      return Medico.fromJson(json);
    } else {
      // Lanza una excepción si el código de estado no es 200
      throw Exception('Error al obtener el medico: ${response.statusCode}');
    }
  }

  //!updateEstablecimiento
  /// Actualiza un establecimiento en la API.
  /// Recibe un objeto Establecimiento y un archivo de imagen opcional.
  /// Devuelve true si la actualización fue exitosa, false en caso contrario.
  Future<bool> updateMedico(Medico est) async {
    try {
      final uri = Uri.parse('${baseUrl}medico');

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
      throw Exception('Error al actualizar medico: $e');
    }
  }

  //! createEstablecimiento
  /// Crea un nuevo establecimiento en la API.
  /// Recibe un objeto Establecimiento y un archivo de imagen opcional.
  /// Devuelve true si la creación fue exitosa, false en caso contrario.
  Future<bool> createMedico(Medico est) async {
    try {
      final uri = Uri.parse('${baseUrl}medico');

      // Genera el cuerpo de la solicitud sin incluir el campo 'id'
      final body = jsonEncode({
        'especialidad': {'id': est.especialidad.id},
        'usuario': {'id': est.usuario.id},
        'estado': est.usuario.id,
        'tarjetaProfe': est.tarjetaProfe,
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
        throw Exception('Error al crear medico: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al crear medico: $e');
    }
  }
  //! deleteEstablecimiento
  /// Realiza un borrado lógico de un establecimiento por ID.
  /// Retorna true si fue exitoso.

  Future<bool> deleteMedico(int id) async {
    final response = await http.delete(Uri.parse('${baseUrl}medico/$id'));

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
      throw Exception('Error al eliminar la medico: ${response.statusCode}');
    }
  }
}
