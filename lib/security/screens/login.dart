import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/shared/widgets/formulario_multi.dart';
import 'package:elvale/usuario/usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';


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


  uid = userCredential.user?.uid ?? 'NO UID FOUND';


  UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);
  EstablecimientoInfoModel? establecimientoInfoModel = await ApiPetition.fetchEstablecimientoById(usuario!.establecimiento!);
  String metodo = userCredential.credential!.signInMethod;
  codeResponse = ApiPetition.codeResponse;
  if (userCredential.user != null && codeResponse == 200) {
        // ignore: avoid_print, prefer_interpolation_to_compose_strings//print("entro " + usuario!.nombres.toString());
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioScreen(uid: uid, usuario: usuario, establecimientoInfoModel: establecimientoInfoModel!,)),
        );
      } else if (metodo == 'google.com') {
    
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => UsuarioNuevoScreen(metodo: metodo,codeResponse: codeResponse, inicio: "google", usuario: usuario, uid: uid,)),
        );
      }



  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  Future<void> _signIn() async {
     if (!mounted) return;
  try {
    // Autenticación con correo y contraseña
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
     if (!mounted) return;

    uid = userCredential.user?.uid ?? 'NO UID FOUND';
    print("id de firebase:: " + uid);
    // Realizar la consulta para obtener el usuario
    UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);

    // Si el servicio devuelve null, significa que el usuario no existe
    if (usuario == null || ApiPetition.codeResponse == 204) {
      print("Usuario no encontrado, redirigiendo a formulario de registro");
      
      // Navegar a la pantalla de registro con los detalles del usuario
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioNuevoScreen(
            codeResponse: ApiPetition.codeResponse,
            inicio: "correo",
            metodo: "correo",
            usuario: usuario!, // Aquí puedes pasar cualquier información relevante
            uid: uid,
          ),
        ),
      );
    } else if (userCredential.user != null && ApiPetition.codeResponse == 200) {
      // Si el usuario existe y la respuesta del servicio es correcta (200)
      EstablecimientoInfoModel? establecimientoInfoModel = await ApiPetition.fetchEstablecimientoById(usuario.establecimiento!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioScreen(
            uid: uid,
            usuario: usuario,
            establecimientoInfoModel: establecimientoInfoModel!,
          ),
        ),
      );
    }
  } catch (e) {
     if (!mounted) return;
    setState(() {
      print("Error: $e");
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
