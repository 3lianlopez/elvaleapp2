import 'package:elvale/establecimiento/establecimiento.dart';
import 'package:elvale/establecimiento/provider/establacimiento_provider.dart';
import 'package:elvale/routes/routes.dart';
import 'package:elvale/security/screens/login.dart';
import 'package:elvale/usuario/provider/usuario_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstablecimientoProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()) 
      ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getAplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) =>  LoginScreen());
      },
    );
  }
}


