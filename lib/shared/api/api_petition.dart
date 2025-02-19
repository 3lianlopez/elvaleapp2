import 'dart:convert';

import 'package:elvale/clientes/models/cuenta_model.dart';
import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/usuario/models/usuario_new_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiPetition {
  static int codeResponse = 0;

  static Future<UsuarioSecurityModel?> fetchUsuarioById(String id) async {
    print(id);
    //id = "tiaoS2g1btVwMXJzlrYRHjZ72tV1";
    final url = Uri.parse('http://192.168.1.131:8080/api/usuarios/$id');
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
        print(json.decode(response.body));

        return UsuarioSecurityModel.fromJson(
            json.decode(response.body)['data']);
      } else if (codeResponse == 404) {
        // ignore: avoid_print
        print("response --- ${response.body}");
        return UsuarioSecurityModel();
      } else {
        // ignore: avoid_print
        print(
            'Error: No se pudo obtener el usuario. Código de estado: ${response.statusCode}');

        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al hacer la solicitud: $e');

      return null;
    }
  }

  static Future<EstablecimientoInfoModel?> fetchEstablecimientoById(
      String id) async {
    //id = "tiaoS2g1btVwMXJzlrYRHjZ72tV1";
    final url = Uri.parse('http://192.168.1.131:8080/api/establecimientos/$id');
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
      } else if (codeResponse == 204) {
        // ignore: avoid_print
        print("usuario 204");
        return EstablecimientoInfoModel();
      } else {
        // ignore: avoid_print
        print(
            'Error: No se pudo obtener el usuario. Código de estado: ${response.statusCode}');

        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al hacer la solicitud: $e');

      return null;
    }
  }

  static Future<void> crearEstablecimiento(EstablecimientoModel empresa) async {
    final url = Uri.parse(
        'http://192.168.1.131:8080/establecimiento'); // Reemplaza con la URL de tu API

    try {
      // Convertir el objeto Empresa a JSON
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Asegúrate de enviar JSON
        },
        body: json.encode(
            empresa.toJson()), // Enviar el JSON generado por el método toJson
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

  static Future<dynamic> buscarClientePorDocumento({
    required String tipoDocumento,
    required String documento,
  }) async {
    final url = Uri.parse(
        'http://192.168.1.131:8080/api/clientes/td/$tipoDocumento/$documento');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('No se encontró el cliente');
      }
    } catch (e) {
      throw Exception('Error al buscar el cliente: $e');
    }
  }

  static Future<void> crearCuenta(Map<String, dynamic> cuenta) async {
    final url = Uri.parse('http://192.168.1.131:8080/api/cuentas');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cuenta),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Error al crear la cuenta');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<Map<String, dynamic>> enviarEstablecimiento({
    required EstablecimientoModel establecimiento,
    required UsuarioNewAdmin usuario,
  }) async {
    try {
      final responseEstablecimiento = await http.post(
        Uri.parse('http://192.168.1.131:8080/api/establecimientos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(establecimiento.toJson()),
      );

      if (responseEstablecimiento.statusCode != 200 &&
          responseEstablecimiento.statusCode != 201) {
        throw Exception('Error creating establishment');
      }

      final responseUsuario = await http.post(
        Uri.parse('http://192.168.1.131:8080/api/usuarios'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(usuario.toJson()),
      );

      if (responseUsuario.statusCode != 200 &&
          responseUsuario.statusCode != 201) {
        throw Exception('Error creating user');
      }

      await Future.delayed(const Duration(seconds: 1));

      final usuarioCreado = await fetchUsuarioById(usuario.id!);
      if (usuarioCreado == null) {
        throw Exception('Error fetching created user');
      }

      final establecimientoInfo =
          await fetchEstablecimientoById(usuarioCreado.establecimiento!);
      if (establecimientoInfo == null) {
        throw Exception('Error fetching establishment info');
      }

      return {
        'usuario': usuarioCreado,
        'establecimiento': establecimientoInfo,
      };
    } catch (e) {
      rethrow;
    }
  }
}
