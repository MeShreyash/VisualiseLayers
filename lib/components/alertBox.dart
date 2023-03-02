// import 'package:flutter/material.dart';

// void main() => runApp( MyApp());

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('AlertDialog Sample')),
//         body: const Center(
//           child: AlertBox(),
//         ),
//       ),
//     );
//   }
// }

// class AlertBox extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('All data shown'),
//           content: const Text('No more locations can be found'),
          
//         ),
//       ),
//       child: const Text('Show Dialog'),
//     );
//   }
// }
