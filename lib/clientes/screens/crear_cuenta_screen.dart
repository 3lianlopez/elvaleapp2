import 'package:flutter/material.dart';
import 'package:elvale/shared/database/database_helper.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:uuid/uuid.dart';

class CrearCuentaScreen extends StatefulWidget {
  final Map<String, dynamic> cliente;

  const CrearCuentaScreen({super.key, required this.cliente});

  @override
  State<CrearCuentaScreen> createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _observacionesController = TextEditingController();
  final _nombreCuentaController = TextEditingController(); // Add this line
  bool _isLoading = false;
  // Remove _selectedTipo and _tipos variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crear Cuenta',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1E88E5),
          elevation: 0,
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1E88E5).withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.blue.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cliente: ${widget.cliente['nombres']} ${widget.cliente['apellidos']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _nombreCuentaController,
                                    decoration: InputDecoration(
                                      labelText: 'Nombre de Cuenta',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                    ),
                                    validator: (value) => value?.isEmpty ?? true
                                        ? 'Campo requerido'
                                        : null,
                                  ),
                                  const SizedBox(height: 16),
                                  // Remove DropdownButtonFormField for tipo
                                  TextFormField(
                                    controller: _montoController,
                                    decoration: InputDecoration(
                                      labelText: 'Monto Aprobado',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) => value?.isEmpty ?? true
                                        ? 'Campo requerido'
                                        : null,
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _observacionesController,
                                    decoration: InputDecoration(
                                      labelText: 'Observaciones',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                    ),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF1E88E5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed:
                                          _isLoading ? null : _crearCuenta,
                                      child: _isLoading
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            )
                                          : const Text(
                                              'Crear Cuenta',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  Future<void> _crearCuenta() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final establecimiento =
          await DatabaseHelper().obtenerEstablecimientoActual();
      if (establecimiento == null) {
        throw Exception('No se encontró información del establecimiento');
      }

      final cuenta = {
        'id': const Uuid().v4(),
        'idEstablecimiento': establecimiento['id'],
        'idCliente': widget.cliente['id'],
        'montoAprobado': double.parse(_montoController.text),
        'tipo': _nombreCuentaController.text, // Add this line
        'observaciones': _observacionesController.text,
        'estado': 'PENDIENTE',
      };

      await ApiPetition.crearCuenta(cuenta);

      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada exitosamente')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
