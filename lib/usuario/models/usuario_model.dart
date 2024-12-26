// lib/models/usuario_admin.dart

class UsuarioModel {
  final String tipoIdentificacion;
  final String identificacion;
  final String nombres;
  final String apellidos;
  final String direccion;
  final String descripcion;
  final String email;
  final String celular;

  UsuarioModel({
    required this.tipoIdentificacion,
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.direccion,
    required this.descripcion,
    required this.email,
    required this.celular,
  });

  // Convertir el objeto UsuarioAdmin a un mapa
  Map<String, dynamic> toMap() {
    return {
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'descripcion': descripcion,
      'email': email,
      'celular': celular,
    };
  }
}
