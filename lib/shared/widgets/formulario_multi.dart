import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/screens/usuario_correo.dart';
import 'package:elvale/shared/screens/usuario_google.dart';
import 'package:flutter/material.dart';



class UsuarioNuevoScreen extends StatefulWidget {
  final String metodo;
  final int codeResponse;
  final String inicio;
  final UsuarioSecurityModel usuario;
  final String uid;

  const UsuarioNuevoScreen({super.key, required this.metodo ,  required this.codeResponse , required this.inicio, required this.usuario , required this.uid});

  @override
  // ignore: library_private_types_in_public_api
  _UsuarioNuevoScreenState createState() => _UsuarioNuevoScreenState();
}

class _UsuarioNuevoScreenState extends State<UsuarioNuevoScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.codeResponse == 204 
        ? Text('Formulario Establecimiento')
        : Text(widget.usuario.nombres!)      
      ),
      body: widget.metodo == "google.com"
        //VALIDACION SI TIENE O NO ESTABLECIMIENTO ASIGNADO
        //INICIO DE SESION CON GOOGLE
        ?  UsuarioGoogle(coderesponse: widget.codeResponse,)
        //INICIO DE SESION CON CORREO Y CLAVE
        :  UsuarioCorreo(coderesponse: widget.codeResponse, uid: widget.uid,)
      
    );
  }
}







