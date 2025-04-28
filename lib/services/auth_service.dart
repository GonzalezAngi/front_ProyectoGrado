import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_proyectogrado/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = dotenv.env['URL_API']!;

  //! login se encarga de autenticar al usuario
  Future<Map<String, dynamic>> login(
    String tipoUsuario,
    String contrasena,
    String identificacion,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tipoUsuario': tipoUsuario,
        'contrasena': contrasena,
        'identificacion': identificacion,
      }),
    );

    if (response.statusCode == 200) {
      // Verifica si el cuerpo de la respuesta no está vacío
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);

        try {
          final prefs = await SharedPreferences.getInstance();

          // Manejo del token
          if (data['token'] != null) {
            await prefs.setString('token', data['token']);
          } else {
            debugPrint(
              'El token es nulo. No se puede guardar en SharedPreferences.',
            );
          }

          // Manejo del usuario
          if (data['user'] != null && data['user'] is Map<String, dynamic>) {
            await prefs.setString('user', jsonEncode(data['user']));
            return {'success': true, 'user': User.fromJson(data['user'])};
          } else {
            debugPrint('El usuario es nulo o no es un objeto válido.');
            return {
              'success': true,
              'message':
                  'Inicio de sesión exitoso, pero no se recibió información del usuario.',
            };
          }
        } catch (e) {
          debugPrint('Error al guardar datos en SharedPreferences: $e');
          return {
            'success': false,
            'message': 'Error interno al procesar los datos.',
          };
        }
      } else {
        // Si el cuerpo de la respuesta está vacío
        return {
          'success': false,
          'message': 'Usuario o contraseña incorrectos',
        };
      }
    } else {
      // Manejo de errores
      if (response.body.isNotEmpty) {
        try {
          final data = jsonDecode(response.body);
          return {
            'success': false,
            'message': data['message'] ?? 'Usuario incorrecto',
          };
        } catch (e) {
          return {
            'success': false,
            'message': 'Error desconocido. Por favor, inténtelo de nuevo.',
          };
        }
      } else {
        // Si el cuerpo de la respuesta está vacío
        return {'success': false, 'message': 'Error con servidor'};
      }
    }
  } //! register se encarga de registrar al usuario

  //* se le pasa el nombre, telefono, email, identificación, genero, estado, tipo identificacion, contraseña y tipo usuario al servidor
  Future<Map<String, dynamic>> register(
    String nombre,
    String telefono,
    String email,
    String identificacion,
    String genero,
    String estado,
    String tipoIdentificacion,
    String contrasena,
    String tipoUsuario,
  ) async {
    print('Datos enviados al servidor:');
    print({
      'nombre': nombre,
      'telefono': telefono,
      'email': email,
      'identificacion': identificacion,
      'genero': genero,
      'estado': estado,
      'tipoIdentificacion': tipoIdentificacion,
      'contrasena': contrasena,
      'tipoUsuario': tipoUsuario,
    });

    final response = await http.post(
      Uri.parse('${baseUrl}register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'telefono': telefono,
        'email': email,
        'identificacion': identificacion,
        'genero': genero,
        'estado': estado,
        'tipoIdentificacion': tipoIdentificacion,
        'contrasena': contrasena,
        'tipoUsuario': tipoUsuario,
      }),
    );

    print('Respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final data = jsonDecode(response.body);
      return {
        'success': false,
        'message': data['message'] ?? 'Error en registro',
        'errors': data['errors'],
      };
    }
  }

  //! getUser se encarga de obtener el usuario
  //* se obtiene el usuario de SharedPreferences
  Future<User?> getUser() async {
    try {
      //* se obtiene el usuario de SharedPreferences
      //* se convierte el objeto a JSON
      final prefs = await SharedPreferences.getInstance();
      final userStr = prefs.getString('user');
      if (userStr != null) {
        return User.fromJson(jsonDecode(userStr));
      }
    } catch (e) {
      debugPrint('Error al obtener SharedPreferences: $e');
    }
    return null;
  }

  //! getToken se encarga de obtener el token
  //* se obtiene el token de SharedPreferences
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      debugPrint('Error al obtener token: $e');
      return null;
    }
  }

  //! isLoggedIn se encarga de verificar si el usuario está logueado
  //* se verifica si el token existe en SharedPreferences
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}
