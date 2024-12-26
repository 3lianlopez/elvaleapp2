// lib/models/establecimiento.dart

import 'package:elvale/usuario/models/usuario_model.dart';


class EstablecimientoModel {
  final String nit;
  final String razonSocial;
  final String descripcion;
  final String observaciones;
  final String direccion;
  final UsuarioModel usuarioAdmin;

  EstablecimientoModel({
    required this.nit,
    required this.razonSocial,
    required this.descripcion,
    required this.observaciones,
    required this.direccion,
    required this.usuarioAdmin,
  });

  // Convertir el objeto Establecimiento a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nit': nit,
      'razonSocial': razonSocial,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'direccion': direccion,
      'usuarioAdmin': usuarioAdmin.toMap(),
    };
  }
}