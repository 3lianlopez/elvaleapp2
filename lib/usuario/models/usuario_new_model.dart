// Modelo para UsuarioAdmin
class UsuarioNewAdmin {
  String? id;
  String? uid;
  String? tipoIdentificacion;
  String? identificacion;
  String? nombres;
  String? apellidos;
  String? direccion;
  String? descripcion;
  String? referencia;
  String? observaciones;
  String? estado;
  String? email;
  String? celular;
  String? rol;
  String? establecimiento;

  // Constructor
  UsuarioNewAdmin(
      {this.id,
      this.uid,
      this.tipoIdentificacion,
      this.identificacion,
      this.nombres,
      this.apellidos,
      this.direccion,
      this.descripcion,
      this.referencia,
      this.observaciones,
      this.estado,
      this.email,
      this.celular,
      this.rol,
      this.establecimiento});

  // Método fromJson: Convertir un JSON a un objeto UsuarioNewAdmin
  factory UsuarioNewAdmin.fromJson(Map<String, dynamic> json) {
    return UsuarioNewAdmin(
        id: json['id'],
        uid: json['uid'],
        tipoIdentificacion: json['tipoIdentificacion'],
        identificacion: json['identificacion'],
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        direccion: json['direccion'],
        descripcion: json['descripcion'],
        referencia: json['referencia'],
        observaciones: json['observaciones'],
        estado: json['estado'],
        email: json['email'],
        celular: json['celular'],
        rol: json['rol'],
        establecimiento: json['id']);
  }

  // Método toJson: Convertir un objeto UsuarioAdmin a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'descripcion': descripcion,
      'referencia': referencia,
      'observaciones': "Sin observaciones",
      'estado': "Pendiente",
      'email': email,
      'celular': celular,
      'rol': "ENC",
      'establecimiento': id
    };
  }

  // Método toMap: Convertir un objeto UsuarioAdmin a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'descripcion': descripcion,
      'referencia': referencia,
      'observaciones': "Sin observaciones",
      'estado': "Pendiente",
      'email': email,
      'celular': celular,
      'rol': "ENC",
      'establecimiento': id
    };
  }
}
