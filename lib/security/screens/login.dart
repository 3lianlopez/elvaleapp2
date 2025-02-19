import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/shared/images/image_assets.dart';
import 'package:elvale/shared/widgets/formulario_multi.dart';
import 'package:elvale/usuario/usuario_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:elvale/shared/database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Add this at the top with other variables
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String uid = '';
  String? _errorMessage;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    int codeResponse = 0;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    uid = userCredential.user?.uid ?? 'NO UID FOUND';

    UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);
    EstablecimientoInfoModel? establecimientoInfoModel =
        await ApiPetition.fetchEstablecimientoById(usuario!.establecimiento!);
    String metodo = userCredential.credential!.signInMethod;
    codeResponse = ApiPetition.codeResponse;
    if (userCredential.user != null && codeResponse == 200) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings//print("entro " + usuario!.nombres.toString());
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => UsuarioScreen(
                  uid: uid,
                  usuario: usuario,
                  establecimientoInfoModel: establecimientoInfoModel!,
                )),
      );
    } else if (metodo == 'google.com') {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => UsuarioNuevoScreen(
                  metodo: metodo,
                  codeResponse: codeResponse,
                  inicio: "google",
                  usuario: usuario,
                  uid: uid,
                )),
      );
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _signIn() async {
    if (!mounted) return;

    setState(() => _isLoading = true); // Set loading state

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("TRY USERCREDENTIAL:: " + userCredential.user!.uid.toString());

      if (!mounted) return;

      uid = userCredential.user?.uid ?? 'NO UID FOUND';
      print("id de firebase:: $uid");
      // Realizar la consulta para obtener el usuario
      UsuarioSecurityModel? usuario = await ApiPetition.fetchUsuarioById(uid);
      print(usuario!.toJson());
      // Si el servicio devuelve null, significa que el usuario no existe
      if (ApiPetition.codeResponse == 404) {
        print("Usuario no encontrado, redirigiendo a formulario de registro");

        // Navegar a la pantalla de registro con los detalles del usuario
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UsuarioNuevoScreen(
              codeResponse: ApiPetition.codeResponse,
              inicio: "correo",
              metodo: "correo",
              usuario: usuario ??
                  UsuarioSecurityModel(), // Aquí puedes pasar cualquier información relevante
              uid: uid,
            ),
          ),
        );
      } else if (userCredential.user != null &&
          ApiPetition.codeResponse == 200) {
        // Si el usuario existe y la respuesta del servicio es correcta (200)
        EstablecimientoInfoModel? establecimientoInfoModel =
            await ApiPetition.fetchEstablecimientoById(
                usuario.establecimiento!);
// After successful login and fetching user/establishment data
        await DatabaseHelper().guardarEstablecimientoYUsuario(
          establecimiento: establecimientoInfoModel!.toJson(),
          usuario: {
            'uid': usuario.uid,
            'establecimiento_id': establecimientoInfoModel.id,
            'nombres': usuario.nombres,
            'apellidos': usuario.apellidos,
            'email': usuario.email,
            'rol': usuario.rol,
          },
        );
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // Reset loading state
        });
      }
    }
  }

  // Update the login button in build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF424242).withOpacity(0.9),
              const Color(0xFF757575).withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Bienvenido',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon:
                              const Icon(Icons.email, color: Color(0xFF757575)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          errorText:
                              _errorMessage != null ? 'Correo inválido' : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xFF757575)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          errorText: _errorMessage != null
                              ? 'Contraseña inválida'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF424242),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'O continúa con',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: signInWithGoogle,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              ImageAssets.getImageAssets('icon_google'),
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Google',
                              style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
