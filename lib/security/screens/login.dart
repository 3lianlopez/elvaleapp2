import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/shared/screens/usuario_google.dart';
import 'package:elvale/shared/widgets/formulario_multi.dart';
import 'package:elvale/usuario/usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String uid ='';

  String? _errorMessage;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  int codeResponse = 0;
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  print(userCredential.user!.uid.toString());

  uid = userCredential.user?.uid ?? 'NO UID FOUND';

  UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);
  codeResponse = ApiPetition.codeResponse;
  if (userCredential.user != null && codeResponse == 200) {
        // ignore: avoid_print, prefer_interpolation_to_compose_strings//print("entro " + usuario!.nombres.toString());
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioScreen(uid: uid, usuario: usuario!)),
        );
      } else if (userCredential.user != null && codeResponse == 204) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioNuevoScreen(codeResponse: codeResponse)),
        );
      }



  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  Future<void> _signIn() async {
    try {
      // Autenticación con correo y contraseña
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );


      uid = userCredential.user?.uid ?? 'NO UID FOUND';
      UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      // Si la autenticación es exitosa, navega a la pantalla principal
      if (userCredential.user != null && ApiPetition.codeResponse == 200) {
        // ignore: avoid_print, prefer_interpolation_to_compose_strings//print("entro " + usuario!.nombres.toString());
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioScreen(uid: uid, usuario: usuario!)),
        );
      } else if (userCredential.user != null && ApiPetition.codeResponse == 204) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioNuevoScreen(codeResponse: ApiPetition.codeResponse,)),
        );
      }
    } catch (e) {
      setState(() {
        // ignore: avoid_print, prefer_interpolation_to_compose_strings
        print("Mensaje"+ e.toString());
        _errorMessage = "Error al iniciar sesión: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio de sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                errorText: _errorMessage != null ? "Correo inválido" : null,
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Contraseña",
                errorText: _errorMessage != null ? "Contraseña inválida" : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){              
              _signIn();
                
              },
              child: Text("Iniciar sesión"),
            ),

            IconButton(onPressed: ()async{
              await signInWithGoogle();
            }, icon: Icon(Icons.abc),),
            
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
