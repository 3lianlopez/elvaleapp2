import 'dart:convert';

import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/usuario/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/usuario/models/usuario_new_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UsuarioCorreo extends StatefulWidget {
  //PARAMETRO DE LA PANTALLA REQUERIDO PARA VALIDAR SI TIENE O NO INFORMACION PARA ARMAR LA PANTALLA
  final int coderesponse;
  final String uid;
  const UsuarioCorreo(
      {super.key, required this.coderesponse, required this.uid});

  @override
  State<UsuarioCorreo> createState() => _UsuarioCorreoState();
}

class _UsuarioCorreoState extends State<UsuarioCorreo> {
  var uuid = Uuid();
  // Controladores para los campos del formulario
  final TextEditingController nitController = TextEditingController();
  final TextEditingController razonSocialController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController observacionesController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();

  // Usuario Admin
  final TextEditingController tipoIdentificacionController =
      TextEditingController();
  final TextEditingController identificacionController =
      TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController celularController = TextEditingController();

  Future<void> enviarEstablecimiento() async {
    print("UID EN ESTALECIMIENTO::: ${widget.uid}");
    // Crear el objeto UsuarioAdmin
    String uuiduser = uuid.v4();
    print("object::: $uuiduser");
    final usuarioNewAdmin = UsuarioNewAdmin(
        id: uuiduser,
        uid: widget.uid,
        tipoIdentificacion: tipoIdentificacionController.text,
        identificacion: identificacionController.text,
        nombres: nombresController.text,
        apellidos: apellidosController.text,
        direccion: direccionController.text,
        descripcion: descripcionController.text,
        referencia: "REF123456",
        estado: 'PENDIENTE',
        email: emailController.text,
        celular: celularController.text,
        rol: "ENC",
        establecimiento: uuiduser);

    // Crear el objeto Establecimiento
    final establecimiento = EstablecimientoModel(
      id: uuiduser,
      nit: nitController.text,
      razonSocial: razonSocialController.text,
      descripcion: descripcionController.text,
      observaciones: observacionesController.text,
      direccion: direccionController.text,
    );

    // Convertir el establecimiento a JSON
    final jsonBody = jsonEncode(establecimiento.toJson());
    print("JSONBODY::: $jsonBody");
    // Realizar la petición POST
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.131:8080/api/establecimientos'), // Asegúrate de que esta URL es correcta
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    final jsonBody2 = jsonEncode(usuarioNewAdmin.toJson());

    final response2 = await http.post(
      Uri.parse(
          'http://192.168.1.131:8080/api/usuarios'), // Asegúrate de que esta URL es correcta
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody2,
    );

    print("RESPONSE::: ${response.statusCode}");
    print("RESPONSE2::: ${response2.statusCode}");

    print("BODY::: ${response.body}");

    if (response2.statusCode == 200 || response2.statusCode == 201) {
      UsuarioSecurityModel? usuario =
          await ApiPetition.fetchUsuarioById(uuiduser);
      EstablecimientoInfoModel? establecimientoInfoModel =
          await ApiPetition.fetchEstablecimientoById(usuario!.establecimiento!);
      print(response2.statusCode);
      // ignore: use_build_context_synchronously
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioScreen(
            uid: uuiduser,
            usuario: usuario!,
            establecimientoInfoModel: establecimientoInfoModel!,
          ),
        ),
      );*/
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Establecimiento creado con éxito')));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear establecimiento')));
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      UsuarioSecurityModel? usuario =
          await ApiPetition.fetchUsuarioById(widget.uid);
      EstablecimientoInfoModel? establecimientoInfoModel =
          await ApiPetition.fetchEstablecimientoById(
              usuario?.establecimiento ?? '');

      print("antes del navigator " + response.statusCode.toString());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioScreen(
            uid: widget.uid,
            usuario: usuario!,
            establecimientoInfoModel: establecimientoInfoModel!,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Establecimiento creado con éxito')));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear establecimiento')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          child: widget.coderesponse == 404
              ? Form(
                  child: Column(
                    children: [
                      // Campos de texto para el establecimiento
                      TextFormField(
                        controller: nitController,
                        decoration: const InputDecoration(labelText: 'NIT'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: razonSocialController,
                        decoration:
                            const InputDecoration(labelText: 'Razón Social'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: descripcionController,
                        decoration:
                            const InputDecoration(labelText: 'Descripción'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: observacionesController,
                        decoration:
                            const InputDecoration(labelText: 'Observaciones'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: direccionController,
                        decoration:
                            const InputDecoration(labelText: 'Dirección'),
                      ),
                      const Divider(thickness: 2),

                      // Campos de texto para el usuario administrador
                      TextFormField(
                        controller: tipoIdentificacionController,
                        decoration: const InputDecoration(
                            labelText: 'Tipo de Identificación'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: identificacionController,
                        decoration:
                            const InputDecoration(labelText: 'Identificación'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: nombresController,
                        decoration: const InputDecoration(labelText: 'Nombres'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: apellidosController,
                        decoration:
                            const InputDecoration(labelText: 'Apellidos'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const Divider(thickness: 2),
                      TextFormField(
                        controller: celularController,
                        decoration: const InputDecoration(labelText: 'Celular'),
                      ),
                      const Divider(thickness: 2),

                      // Botón para enviar el formulario
                      ElevatedButton(
                        onPressed: () {
                          enviarEstablecimiento();
                        },
                        child: const Text('Enviar Establecimiento'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [Text("usuario ya tiene establecimiento")],
                )),
    );
  }
}

void crearEstablecimiento() {}
