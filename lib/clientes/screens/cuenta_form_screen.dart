// import 'package:flutter/material.dart';
// import 'package:elvale/clientes/models/cuenta_model.dart';
// import 'package:elvale/shared/api/api_petition.dart';
// import 'package:uuid/uuid.dart';

// class CuentaFormScreen extends StatefulWidget {
//   final String idEstablecimiento;

//   const CuentaFormScreen({super.key, required this.idEstablecimiento});

//   @override
//   State<CuentaFormScreen> createState() => _CuentaFormScreenState();
// }

// class _CuentaFormScreenState extends State<CuentaFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _cuenta = CuentaModel();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _cuenta.idEstablecimiento = widget.idEstablecimiento;
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() => _isLoading = true);

//       try {
//         final success = await ApiPetition.crearCuenta(_cuenta);
//         if (!mounted) return;

//         if (success) {
//           Navigator.pop(context, true);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Cuenta creada exitosamente')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Error al crear la cuenta')),
//           );
//         }
//       } finally {
//         if (mounted) setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nueva Cuenta'),
//         backgroundColor: const Color(0xFF424242),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Información del Cliente',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF424242),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'ID Cliente',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[50],
//                           ),
//                           validator: (value) =>
//                               value?.isEmpty ?? true ? 'Campo requerido' : null,
//                           onSaved: (value) => _cuenta.idCliente = value,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Monto Aprobado',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[50],
//                           ),
//                           keyboardType: TextInputType.number,
//                           validator: (value) =>
//                               value?.isEmpty ?? true ? 'Campo requerido' : null,
//                           onSaved: (value) => _cuenta.montoAprobado =
//                               double.tryParse(value ?? '0'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Detalles de la Cuenta',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF424242),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Nombre de cuenta',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[50],
//                           ),
//                           maxLines: 3,
//                           onSaved: (value) => _cuenta.tipo = value,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Observaciones',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[50],
//                           ),
//                           maxLines: 3,
//                           onSaved: (value) => _cuenta.observaciones = value,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF424242),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _submitForm,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             'Crear Cuenta',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
