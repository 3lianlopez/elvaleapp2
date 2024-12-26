// lib/screens/usuario_admin_screen.dart

import 'package:elvale/usuario/provider/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioAdminScreen extends StatelessWidget {
  const UsuarioAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Usuario Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: usuarioProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: usuarioProvider.tipoIdentificacionController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Identificación',
                  icon: Icon(Icons.person),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.identificacionController,
                decoration: const InputDecoration(
                  labelText: 'Identificación',
                  icon: Icon(Icons.person),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.nombresController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  icon: Icon(Icons.person),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.apellidosController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  icon: Icon(Icons.person),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  icon: Icon(Icons.location_on),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  icon: Icon(Icons.description),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
              ),
              const Divider(thickness: 2),
              TextFormField(
                controller: usuarioProvider.celularController,
                decoration: const InputDecoration(
                  labelText: 'Celular',
                  icon: Icon(Icons.phone),
                ),
              ),
              const Divider(thickness: 2),
              ElevatedButton(
                onPressed: () {
                  if (usuarioProvider.formKey.currentState?.validate() ?? false) {
                  //print('USUARIO');

                    // Una vez el formulario de usuario admin se envíe
                    Navigator.pushNamed(context, '/establecimiento');
                  }
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
