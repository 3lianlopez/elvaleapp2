import 'package:elvale/usuario/models/usuario_new_model.dart';

class EstablecimientoModel {
  final String id;
  final String nit;
  final String razonSocial;
  final String descripcion;
  final String observaciones;
  final String direccion;

  EstablecimientoModel(
      {required this.id,
      required this.nit,
      required this.razonSocial,
      required this.descripcion,
      required this.observaciones,
      required this.direccion});

  // Convertir el objeto Establecimiento a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion
    };
  }

  // Convertir el objeto Establecimiento a un JSON (usando la instancia para acceder a toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion
    };
  }
}
