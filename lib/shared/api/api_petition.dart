import 'dart:convert';

import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:http/http.dart' as http;


abstract class ApiPetition {

  static int codeResponse = 0;


static Future<UsuarioSecurityModel?> fetchUsuarioById(String id) async {
  //id = "tiaoS2g1btVwMXJzlrYRHjZ72tV1";
  final url = Uri.parse('http://192.168.1.109:8085/usuario/id/$id');
  // ignore: avoid_print
  print(url);
  try {
    
    final response = await http.get(url);

    // ignore: avoid_print
    print(response.statusCode);
    codeResponse = response.statusCode;
    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos el cuerpo
    
      // ignore: avoid_print
      print(response.body);
    
      return UsuarioSecurityModel.fromJson(json.decode(response.body));
    
    } else if (codeResponse == 204){
      // ignore: avoid_print
      print("response --- " + response.body);
      return UsuarioSecurityModel();

    } else {
    
      // ignore: avoid_print
      print('Error: No se pudo obtener el usuario. Código de estado: ${response.statusCode}');
    
      return null;
    }
  } catch (e) {
    
    // ignore: avoid_print
    print('Error al hacer la solicitud: $e');
    
    return null;
  }
}

static Future<EstablecimientoInfoModel?> fetchEstablecimientoById(String id) async {
  //id = "tiaoS2g1btVwMXJzlrYRHjZ72tV1";
  final url = Uri.parse('http://192.168.1.109:8085/establecimiento/id/$id');
  // ignore: avoid_print
  print(url);
  try {
    
    final response = await http.get(url);

    // ignore: avoid_print
    print(response.statusCode);
    codeResponse = response.statusCode;
    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos el cuerpo
    
      // ignore: avoid_print
      print(response.body);
    
      return EstablecimientoInfoModel.fromJson(json.decode(response.body));
    
    } else if (codeResponse == 204){
      // ignore: avoid_print
      print("usuario 204");
      return EstablecimientoInfoModel();

    } else {
    
      // ignore: avoid_print
      print('Error: No se pudo obtener el usuario. Código de estado: ${response.statusCode}');
    
      return null;
    }
  } catch (e) {
    
    // ignore: avoid_print
    print('Error al hacer la solicitud: $e');
    
    return null;
  }
}



static Future<void> crearEstablecimiento(EstablecimientoModel empresa) async {
  final url = Uri.parse('http://192.168.1.109:8085/establecimiento'); // Reemplaza con la URL de tu API

  try {
    // Convertir el objeto Empresa a JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',  // Asegúrate de enviar JSON
      },
      body: json.encode(empresa.toJson()), // Enviar el JSON generado por el método toJson
    );
    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, puedes manejar la respuesta de la API aquí
      // ignore: avoid_print
      print('Datos enviados exitosamente');
    } else {
      // ignore: avoid_print
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // ignore: avoid_print
    print('Error al enviar los datos: $e');
  }
}


}