import 'package:elvale/clientes/screens/crear_cuenta_screen.dart';
import 'package:flutter/material.dart';
import 'package:elvale/shared/api/api_petition.dart';

class BuscarClienteScreen extends StatefulWidget {
  const BuscarClienteScreen({super.key});

  @override
  State<BuscarClienteScreen> createState() => _BuscarClienteScreenState();
}

class _BuscarClienteScreenState extends State<BuscarClienteScreen> {
  final _documentoController = TextEditingController();
  String? _selectedTipoDoc;
  bool _isLoading = false;
  dynamic _clienteEncontrado;
  String? _error;

  final List<String> _tiposDocumento = ['CC', 'CE', 'TI', 'PAS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cliente'),
        backgroundColor: const Color(0xFF424242),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedTipoDoc,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Documento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      items: _tiposDocumento.map((String tipo) {
                        return DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTipoDoc = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _documentoController,
                      decoration: InputDecoration(
                        labelText: 'Número de Documento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF424242),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (_selectedTipoDoc == null ||
                                  _documentoController.text.isEmpty) {
                                setState(() {
                                  _error =
                                      'Por favor complete todos los campos';
                                });
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                                _error = null;
                              });

                              try {
                                final cliente =
                                    await ApiPetition.buscarClientePorDocumento(
                                  tipoDocumento: _selectedTipoDoc!,
                                  documento: _documentoController.text,
                                );

                                setState(() {
                                  _clienteEncontrado = cliente['data'];
                                  _isLoading = false;
                                });
                              } catch (e) {
                                setState(() {
                                  _error = e.toString();
                                  _isLoading = false;
                                });
                              }
                            },
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Buscar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_clienteEncontrado != null)
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cliente Encontrado',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF424242),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CrearCuentaScreen(
                                  cliente: _clienteEncontrado,
                                ),
                              ),
                            );
                          },
                          child: const Text('Crear Cuenta'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ])),
    );
  }
}

// Widget _buildInfoRow(String label, String value) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         width: 100,
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF424242),
//           ),
//         ),
//       ),
//       Expanded(
//         child: Text(
//           value,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ),
//     ],
//   );
// }
