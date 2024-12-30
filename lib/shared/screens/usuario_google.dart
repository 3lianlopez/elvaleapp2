import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/usuario/models/usuario_new_model.dart';
import 'package:flutter/material.dart';

class UsuarioGoogle extends StatefulWidget {
  final int coderesponse;
  const UsuarioGoogle({super.key ,required this.coderesponse});

  @override
  State<UsuarioGoogle> createState() => _UsuarioGoogleState();
}

class _UsuarioGoogleState extends State<UsuarioGoogle> {

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

    // Realizar la petición POST
    final response = await http.post(
      Uri.parse('http://192.168.1.109:8085/establecimiento'), // Asegúrate de que esta URL es correcta
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );


    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Establecimiento creado con éxito')));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear establecimiento')));
    }
  }

  @override
  void dispose() {
    // Limpiar los controladores
    nitController.dispose();
    razonSocialController.dispose();
    descripcionController.dispose();
    observacionesController.dispose();
    direccionController.dispose();
    tipoIdentificacionController.dispose();
    identificacionController.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    emailController.dispose();
    celularController.dispose();
    

    nitController.clear();
    razonSocialController.clear();
    descripcionController.clear();
    observacionesController.clear();
    direccionController.clear();
    tipoIdentificacionController.clear();
    identificacionController.clear();
    nombresController.clear();
    apellidosController.clear();
    emailController.clear();
    celularController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
       widget.coderesponse == 204
       ? Text("Nuevo usuario Google")
       : Text("Ya tiene establecimiento")
    );
  }
}