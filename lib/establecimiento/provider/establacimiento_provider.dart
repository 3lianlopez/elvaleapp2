// lib/providers/establecimiento_provider.dart

import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EstablecimientoProvider with ChangeNotifier {
  // Controladores de los campos del formulario
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nitController = TextEditingController();
  TextEditingController razonSocialController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();
  TextEditingController direccionController = TextEditingController();

  // Función para crear el establecimiento
  Future<void> crearEstablecimiento(EstablecimientoModel establecimiento) async {
    
    //print("ESTABLECIMIENTO PROVIDER");
    final url = Uri.parse('https://api.example.com/establecimientos');  // Reemplaza con tu URL

    //print("MAPA DE establecimiento::: " + establecimiento.toMap().toString());
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(establecimiento.toMap()),
      );

      if (response.statusCode == 200) {
        // Respuesta exitosa
        //print('Establecimiento creado exitosamente');
      } else {
        throw Exception('Error al crear el establecimiento');
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  // Limpiar los controladores después de enviar el formulario
  void limpiarFormulario() {
    nitController.clear();
    razonSocialController.clear();
    descripcionController.clear();
    observacionesController.clear();
    direccionController.clear();
  }
}
