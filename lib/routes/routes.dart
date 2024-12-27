

import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/security/screens/login.dart';
import 'package:elvale/usuario/usuario.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){

  return <String, WidgetBuilder>{
    '/' :(context) =>   LoginScreen(),
    //'establecimiento': (context) => EstablecimientoScreen(),
    'usuario' : (context) =>  UsuarioScreen(uid: ModalRoute.of(context)!.settings.arguments as String , usuario: ModalRoute.of(context)!.settings.arguments as UsuarioSecurityModel)
  };

}