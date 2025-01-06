import 'package:flutter/material.dart';

// Mapeado de imágenes para un manejo más organizado
 class ImageAssets {
  static const Map<String, String> images = {
    'google': 'assets/images/icon_google.png'
    // Agregar más imágenes conforme se necesiten
  };

  // Acceso más sencillo a las imágenes usando la clave
  static String getImage(String key) {
    return images[key] ?? 'assets/images/default.png'; // Valor por defecto si no se encuentra la clave
  }
}