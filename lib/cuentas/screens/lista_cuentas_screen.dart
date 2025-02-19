import 'package:flutter/material.dart';
import 'package:elvale/shared/api/api_petition.dart';
import 'package:elvale/shared/database/database_helper.dart';
import 'package:elvale/clientes/screens/crear_cuenta_screen.dart';

class ListaCuentasScreen extends StatefulWidget {
  const ListaCuentasScreen({super.key});

  @override
  State<ListaCuentasScreen> createState() => _ListaCuentasScreenState();
}

class _ListaCuentasScreenState extends State<ListaCuentasScreen> {
  List<dynamic> _cuentas = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargarCuentas();
  }

  Future<void> _cargarCuentas() async {
    try {
      final establecimiento =
          await DatabaseHelper().obtenerEstablecimientoActual();
      if (establecimiento == null) {
        throw Exception('No se encontró información del establecimiento');
      }

      final cuentas = await ApiPetition.obtenerCuentasPorEstablecimiento(
          establecimiento['id']);
      print("ID ESTABLECIMIENTO::: " + cuentas.toString());
      // Obtener información de clientes para cada cuenta
      for (var cuenta in cuentas) {
        try {
          print("CUENTA::: " + cuenta.toString());
          final clienteInfo = await ApiPetition.buscarClientePorId(
            id: cuenta['idCliente'],
          );
          cuenta['clienteInfo'] = clienteInfo;
          print("CUENTA[CLIENTESINFO]:::: " + cuenta['clienteInfo'].toString());
        } catch (e) {
          print('Error al obtener información del cliente: $e');
        }
      }

      setState(() {
        _cuentas = cuentas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas',
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Text(_error!,
                        style: const TextStyle(color: Colors.red)))
                : RefreshIndicator(
                    onRefresh: _cargarCuentas,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _cuentas.length,
                      itemBuilder: (context, index) {
                        final cuenta = _cuentas[index];
                        final clienteInfo = cuenta['clienteInfo'];

                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.blue.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Navegar a detalles de la cuenta
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.blue.withOpacity(0.1),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E88E5)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        cuenta['tipo'] ?? 'Sin nombre',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E88E5),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      clienteInfo != null
                                          ? '${clienteInfo['nombres']} ${clienteInfo['apellidos']}'
                                          : 'Cliente no encontrado',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF424242),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Monto:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF757575),
                                          ),
                                        ),
                                        Text(
                                          '\$${cuenta['montoAprobado']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1E88E5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearCuentaScreen(cliente: {}),
            ),
          ).then((value) {
            if (value == true) {
              _cargarCuentas();
            }
          });
        },
        backgroundColor: const Color(0xFF1E88E5),
        label: const Text('Crear Fiado'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
