import 'package:elvale/usuario/models/usuario_new_model.dart';

class EstablecimientoModel {
  final String nit;
  final String razonSocial;
  final String descripcion;
  final String observaciones;
  final String direccion;
  UsuarioNewAdmin usuarioNewAdmin;  // Aquí tienes una instancia de UsuarioNewAdmin

  EstablecimientoModel({
    required this.nit,
    required this.razonSocial,
    required this.descripcion,
    required this.observaciones,
    required this.direccion,
    required this.usuarioNewAdmin,  // Pasas la instancia de UsuarioNewAdmin
  });

  // Convertir el objeto Establecimiento a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion,
      'usuarioAdmin': usuarioNewAdmin
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
    };
  }
}
