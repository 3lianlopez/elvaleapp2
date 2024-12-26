
import 'package:elvale/establecimiento/establecimiento.dart';
import 'package:elvale/security/screens/login.dart';
import 'package:elvale/usuario/usuario.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){

  return <String, WidgetBuilder>{
    '/' :(context) =>   LoginScreen(),
    'Establecimiento' :(context) =>   EstablecimientoScreen(),
    'usuario' : (context) => const UsuarioAdminScreen()
  };

}