import 'package:elvale/usuario/models/usuario_new_model.dart';

class EstablecimientoModel {
  final String nit;
  final String razonSocial;
  final String descripcion;
  final String observaciones;
  final String direccion;
  final UsuarioNewAdmin usuarioNewAdmin;
  
  // Campos adicionales opcionales
  final String? id;
  final String? tipoIdentificacion;
  final String? identificacion;
  final String? nombres;
  final String? apellidos;
  final String? celular;
  final String? telefono;
  final String? email;
  final String? estado;
  final DateTime? fechaGestion;
  final String? establecimiento;
  final String? rol;
  final String? uid;

  EstablecimientoModel({
    required this.nit,
    required this.razonSocial,
    required this.descripcion,
    required this.observaciones,
    required this.direccion,
    required this.usuarioNewAdmin,
    
    // Campos adicionales opcionales
    this.id,
    this.tipoIdentificacion,
    this.identificacion,
    this.nombres,
    this.apellidos,
    this.celular,
    this.telefono,
    this.email,
    this.estado,
    this.fechaGestion,
    this.establecimiento,
    this.rol,
    this.uid,
  });

  // Convertir el objeto Establecimiento a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion,
      'usuarioAdmin': usuarioNewAdmin.toMap(),
      
      // Campos adicionales opcionales
      'id': id,
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'telefono': telefono,
      'email': email,
      'estado': estado,
      'fechaGestion': fechaGestion?.toIso8601String(),
      'establecimiento': establecimiento,
      'rol': rol,
      'uid': uid,
    };
  }

  // Convertir el objeto Establecimiento a un JSON (usando la instancia para acceder a toJson)
  Map<String, dynamic> toJson() {
    return {
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion,
      'usuarioAdmin': usuarioNewAdmin.toJson(), // Aquí accedes a toJson() de la instancia

      // Campos adicionales opcionales
      'id': id,
      'tipoIdentificacion': tipoIdentificacion,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'telefono': telefono,
      'email': email,
      'estado': estado,
      'fechaGestion': fechaGestion?.toIso8601String(),
      'establecimiento': establecimiento,
      'rol': rol,
      'uid': uid,
    };
  }

  
}
