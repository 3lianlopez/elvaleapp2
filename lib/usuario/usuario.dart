import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/security/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioScreen extends StatelessWidget {
  final String uid;
  final UsuarioSecurityModel usuario;

  UsuarioScreen({super.key, required this.uid, required this.usuario });
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    // Después de cerrar sesión, redirige a la pantalla de login
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombres),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),  // Pasa el context a la función
          ),
        ],
      ),
      body: Center(
        
        child: 
          Text("Bienvenido ${usuario.email}!!!")
      ),
    );
  }
}
