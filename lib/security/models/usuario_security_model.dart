
class UsuarioSecurityModel {
  final String id;
  final String tipoIdentificacion;
  final String identificacion;
  final String nombres;
  final String apellidos;
  final String celular;
  final String direccion;
  final String? telefono;
  final String email;
  final String estado;
  final String fechaGestion;
  final String establecimiento;
  final String rol;
  final String uid;

  UsuarioSecurityModel({
    required this.id,
    required this.tipoIdentificacion,
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.celular,
    required this.direccion,
    this.telefono,
    required this.email,
    required this.estado,
    required this.fechaGestion,
    required this.establecimiento,
    required this.rol,
    required this.uid,
  });

  // Método para convertir la respuesta JSON a un objeto Usuario
  factory UsuarioSecurityModel.fromJson(Map<String, dynamic> json) {
    return UsuarioSecurityModel(
      id: json['id'],
      tipoIdentificacion: json['tipoIdentificacion'],
      identificacion: json['identificacion'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      celular: json['celular'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      email: json['email'],
      estado: json['estado'],
      fechaGestion: json['fechaGestion'],
      establecimiento: json['establecimiento'],
      rol: json['rol'],
      uid: json['uid'],
    );
  }

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
      'estado': estado,
      'fechaGestion': fechaGestion,
      'establecimiento': establecimiento,
      'rol': rol,
      'uid': uid,
    };
  }
}