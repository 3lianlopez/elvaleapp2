

class UsuarioNewAdmin {
  final String tipoIdentificacion;
  final String identificacion;
  final String nombres;
  final String apellidos;
  final String direccion;
  final String descripcion;
  final String email;
  final String celular;

  UsuarioNewAdmin({
    required this.tipoIdentificacion,
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.direccion,
    required this.descripcion,
    required this.email,
    required this.celular,
  });

  // Método para convertir el JSON a un objeto UsuarioNewAdmin
  factory UsuarioNewAdmin.fromJson(Map<String, dynamic> json) {
    return UsuarioNewAdmin(
      tipoIdentificacion: json['tipoIdentificacion'],
      identificacion: json['identificacion'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      direccion: json['direccion'],
      descripcion: json['descripcion'],
      email: json['email'],
      celular: json['celular'],
    );
  }

  // Método para convertir un objeto UsuarioAdmin a JSON
  Map<String, dynamic> toJson() {
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