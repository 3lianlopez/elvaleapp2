
class EstablecimientoInfoModel {
  String? id;
  String? nit;
  String? razonSocial;
  String? direccion;
  String? telefono;
  String? descripcion;
  String? observaciones;
  String? estado;
  String? usuarioGestor;
  DateTime? fechaGestion;
  String? usuarioAprobador;
  DateTime? fechaAprobacion;

  // Constructor
  EstablecimientoInfoModel({
    this.id,
    this.nit,
    this.razonSocial,
    this.direccion,
    this.telefono,
    this.descripcion,
    this.observaciones,
    this.estado,
    this.usuarioGestor,
    this.fechaGestion,
    this.usuarioAprobador,
    this.fechaAprobacion,
  });

  // Método fromJson: Convertir un JSON a un objeto Establecimiento
  factory EstablecimientoInfoModel.fromJson(Map<String, dynamic> json) {
    return EstablecimientoInfoModel(
      id: json['id'],
      nit: json['nit'],
      razonSocial: json['razonSocial'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      descripcion: json['descripcion'],
      observaciones: json['observaciones'],
      estado: json['estado'],
      usuarioGestor: json['usuarioGestor'],
      fechaGestion: json['fechaGestion'] != null
          ? DateTime.parse(json['fechaGestion'])
          : null,
      usuarioAprobador: json['usuarioAprobador'],
      fechaAprobacion: json['fechaAprobacion'] != null
          ? DateTime.parse(json['fechaAprobacion'])
          : null,
    );
  }

  // Método toJson: Convertir un objeto Establecimiento a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nit': nit,
      'razonSocial': razonSocial,
      'direccion': direccion,
      'telefono': telefono,
      'descripcion': descripcion,
      'observaciones': observaciones,
      'estado': estado,
      'usuarioGestor': usuarioGestor,
      'fechaGestion': fechaGestion?.toIso8601String(),
      'usuarioAprobador': usuarioAprobador,
      'fechaAprobacion': fechaAprobacion?.toIso8601String(),
    };
  }
}