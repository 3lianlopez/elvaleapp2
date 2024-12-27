// lib/providers/establecimiento_provider.dart

import 'package:elvale/establecimiento/models/establecimiento_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:flutter/material.dart';


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
   
    try {
      
     ApiPetition.crearEstablecimiento(establecimiento);
      
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  // Limpiar los controladores después de enviar el formulario
  /*  nitController.clear();
    razonSocialController.clear();
    descripcionController.clear();
    observacionesController.clear();
    direccionController.clear();
  }*/
}
