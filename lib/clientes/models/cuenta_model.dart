class CuentaModel {
  String? idEstablecimiento;
  String? idCliente;
  double? montoAprobado;
  String? tipo;
  String? observaciones;

  CuentaModel({
    this.idEstablecimiento,
    this.idCliente,
    this.montoAprobado,
    this.tipo,
    this.observaciones,
  });

  Map<String, dynamic> toJson() => {
        'idEstablecimiento': idEstablecimiento,
        'idCliente': idCliente,
        'montoAprobado': montoAprobado,
        'tipo': tipo,
        'observaciones': observaciones,
      };
}
