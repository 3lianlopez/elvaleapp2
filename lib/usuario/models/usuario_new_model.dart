

// Modelo para UsuarioAdmin
class UsuarioNewAdmin {
  String? uid;
  String? tipoIdentificacion;
  String? identificacion;
  String? nombres;
  String? apellidos;
  String? direccion;
  String? descripcion;
  String? email;
  String? celular;

  // Constructor
  UsuarioNewAdmin({
    this.uid,
    this.tipoIdentificacion,
    this.identificacion,
    this.nombres,
    this.apellidos,
    this.direccion,
    this.descripcion,
    this.email,
    this.celular,
  });

  // Método fromJson: Convertir un JSON a un objeto UsuarioNewAdmin
  factory UsuarioNewAdmin.fromJson(Map<String, dynamic> json) {
    return UsuarioNewAdmin(
      uid: json['uid'],
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

  // Método toJson: Convertir un objeto UsuarioAdmin a un JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
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

   // Método toMap: Convertir un objeto UsuarioAdmin a un Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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