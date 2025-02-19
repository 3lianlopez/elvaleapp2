import 'dart:convert';

import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/usuario/usuario_screen.dart';
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
    try {
      String uuidEstablecimiento = uuid.v4();
      String uuidUsuario = uuid.v4();

      final establecimiento = EstablecimientoModel(
        id: uuidEstablecimiento,
        nit: nitController.text,
        razonSocial: razonSocialController.text,
        descripcion: descripcionController.text,
        observaciones: observacionesController.text,
        direccion: direccionController.text,
      );

      final usuarioNewAdmin = UsuarioNewAdmin(
          id: uuidUsuario,
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
          establecimiento: uuidEstablecimiento);

      final result = await ApiPetition.enviarEstablecimiento(
        establecimiento: establecimiento,
        usuario: usuarioNewAdmin,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioScreen(
            uid: uuidUsuario,
            usuario: result['usuario'],
            establecimientoInfoModel: result['establecimiento'],
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Establecimiento creado con éxito')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: widget.coderesponse == 404
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información del Establecimiento',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Establecimiento Fields
                        TextFormField(
                          controller: nitController,
                          decoration: InputDecoration(
                            labelText: 'NIT',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.business,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: razonSocialController,
                          decoration: InputDecoration(
                            labelText: 'Razón Social',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.store,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: descripcionController,
                          decoration: InputDecoration(
                            labelText: 'Descripcion',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.book,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: observacionesController,
                          decoration: InputDecoration(
                            labelText: 'Observacion',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.remove_red_eye_sharp,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: direccionController,
                          decoration: InputDecoration(
                            labelText: 'Direccion',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.location_on,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Información del Administrador',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Admin Fields
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: nombresController,
                                decoration: InputDecoration(
                                  labelText: 'Nombres',
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  prefixIcon: const Icon(Icons.person,
                                      color: Color(0xFF757575)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: apellidosController,
                                decoration: InputDecoration(
                                  labelText: 'Apellidos',
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  prefixIcon: const Icon(Icons.person_outline,
                                      color: Color(0xFF757575)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: tipoIdentificacionController,
                                decoration: InputDecoration(
                                  labelText: 'Tipo ID',
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  prefixIcon: const Icon(Icons.badge,
                                      color: Color(0xFF757575)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: identificacionController,
                                decoration: InputDecoration(
                                  labelText: 'Número ID',
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  prefixIcon: const Icon(Icons.numbers,
                                      color: Color(0xFF757575)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.email,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: celularController,
                          decoration: InputDecoration(
                            labelText: 'Celular',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.phone_android,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: enviarEstablecimiento,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF424242),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Crear Establecimiento',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Column(
                children: [Text("Usuario ya tiene establecimiento")],
              ),
      ),
    );
  }
}
