import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login.dart';

// Couleurs partagées de l'application — un seul endroit à modifier
const Color teaGreen = Color(0xFFD0F0C0); // vert thé (sidebar)
const Color loginGreen = Color(0xFFE3F5DC); // vert plus clair (fond login)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bassiana',
      theme: ThemeData(
        primaryColor: teaGreen,
        scaffoldBackgroundColor: teaGreen,
        colorScheme: ColorScheme.fromSeed(
          seedColor: teaGreen,
          primary: teaGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: teaGreen,
          foregroundColor: Colors.black87,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: const Login(),
    );
  }
}