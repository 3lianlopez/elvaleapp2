import 'package:elvale/establecimiento/models/establecimiento_info_model.dart';
import 'package:elvale/security/models/usuario_security_model.dart';
import 'package:elvale/security/screens/login.dart';
import 'package:elvale/shared/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elvale/clientes/screens/buscar_cliente_screen.dart';

class UsuarioScreen extends StatelessWidget {
  final String uid;
  final UsuarioSecurityModel usuario;
  final EstablecimientoInfoModel establecimientoInfoModel;

  UsuarioScreen(
      {super.key,
      required this.uid,
      required this.usuario,
      required this.establecimientoInfoModel});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    await DatabaseHelper().limpiarDatos(); // Clear local data

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF424242),
        title: Text(
          establecimientoInfoModel.razonSocial!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF424242), Colors.grey[100]!],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User Profile Section
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,
                            size: 50, color: Color(0xFF424242)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${usuario.nombres} ${usuario.apellidos}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        usuario.email ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Menu Section
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildMenuCard(
                        icon: Icons.people,
                        title: 'Gestionar Clientes',
                        subtitle: 'Administrar información de clientes',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BuscarClienteScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildMenuCard(
                        icon: Icons.group,
                        title: 'Gestionar Usuarios',
                        subtitle: 'Administrar usuarios del sistema',
                        onTap: () {
                          // Add navigation logic
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildMenuCard(
                        icon: Icons.account_balance_wallet,
                        title: 'Gestionar Fiao',
                        subtitle: 'Administrar créditos y pagos',
                        onTap: () {
                          // Add navigation logic
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF424242).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: const Color(0xFF424242)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
