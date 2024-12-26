// lib/providers/usuario_provider.dart

import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController tipoIdentificacionController = TextEditingController();
  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController celularController = TextEditingController();

  Map<String, dynamic> get usuarioAdmin => {
    'tipoIdentificacion': tipoIdentificacionController.text,
    'identificacion': identificacionController.text,
    'nombres': nombresController.text,
    'apellidos': apellidosController.text,
    'direccion': direccionController.text,
    'descripcion': descripcionController.text,
    'email': emailController.text,
    'celular': celularController.text,
  };
}
