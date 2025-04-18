class User {
  final int id;
  final String nombre;
  final String telefono;
  final String email;
  final String identificacion;
  final String genero;
  final String estado;
  final String tipoIdentificacion;
  final String contrasena;
  final String tipoUsuario;

  User({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.identificacion,
    required this.genero,
    required this.estado,
    required this.tipoIdentificacion,
    required this.contrasena,
    required this.tipoUsuario,
  });

  // Convierte un objeto JSON a un objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      email: json['email'],
      identificacion: json['identificacion'],
      genero: json['genero'],
      estado: json['estado'],
      tipoIdentificacion: json['tipoIdentificacion'],
      contrasena: json['contrasena'],
      tipoUsuario: json['tipoUsuario'],
    );
  }

  // Convierte un objeto User a un objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'email': email,
      'identificacion': identificacion,
      'genero': genero,
      'estado': estado,
      'tipoIdentificacion': tipoIdentificacion,
      'contrasena': contrasena,
      'tipoUsuario': tipoUsuario,
    };
  }
}
