// lib/providers/usuario_provider.dart

/*/import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/usuario/models/usuario_new_model.dart';
import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//respuesta codigo de respuesta del servicio
 static int coderesponse = 0;

// Controladores para los campos del formulario
  final TextEditingController nitController = TextEditingController();
  final TextEditingController razonSocialController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController observacionesController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();

  // Usuario Admin
  final TextEditingController tipoIdentificacionController = TextEditingController();
  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController celularController = TextEditingController();

  Future<void> enviarEstablecimiento() async {
    // Crear el objeto UsuarioAdmin
    final usuarioNewAdmin = UsuarioNewAdmin(
      tipoIdentificacion: tipoIdentificacionController.text,
      identificacion: identificacionController.text,
      nombres: nombresController.text,
      apellidos: apellidosController.text,
      direccion: direccionController.text,
      descripcion: descripcionController.text,
      email: emailController.text,
      celular: celularController.text,
    );

    // Crear el objeto Establecimiento
    final establecimiento = EstablecimientoModel(
      nit: nitController.text,
      razonSocial: razonSocialController.text,
      descripcion: descripcionController.text,
      observaciones: observacionesController.text,
      direccion: direccionController.text,
      usuarioNewAdmin: usuarioNewAdmin,
    );

    // Convertir el establecimiento a JSON
    final jsonBody = jsonEncode(establecimiento.toJson());

    print(jsonBody);
    // Realizar la petición POST
    final response = await http.post(
      Uri.parse('http://192.168.1.109:8085/establecimiento'), // Asegúrate de que esta URL es correcta
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    print("RESPONSE::: " + response.body);

    print("coderesponse:: " + response.statusCode.toString());

    coderesponse = response.statusCode;

    if (response.statusCode == 200 || response.statusCode == 201) {
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Establecimiento creado con éxito')));
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear establecimiento')));
    }
  }

}
*/

