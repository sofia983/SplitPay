import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const SplitPayApp());
}

/// Aplicación principal de Split Pay.
/// En esta primera versión solo se implementa la navegación.
class SplitPayApp extends StatelessWidget {
  const SplitPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Split Pay',

      // Tema general de la aplicación.
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C3FE8),
        ),
        fontFamily: 'Roboto',
      ),

      // La primera pantalla es el inicio de sesión.
      home: const LoginScreen(),
    );
  }
}