import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/languages.dart';
import 'sidebar_page.dart';
import '../main.dart'; // fournit teaGreen et loginGreen

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Langue actuelle (par défaut : français)
  String _currentLang = 'fr';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Liste des langues disponibles avec libellé et drapeau
  static const List<Map<String, String>> _availableLanguages = [
    {'code': 'fr', 'label': 'Français', 'flag': '🇫🇷'},
    {'code': 'en', 'label': 'English', 'flag': '🇬🇧'},
    {'code': 'ar', 'label': 'العربية', 'flag': '🇸🇦'},
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Choisir la langue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ..._availableLanguages.map((opt) {
                final isSelected = _currentLang == opt['code'];
                return ListTile(
                  leading:
                  Text(opt['flag']!, style: const TextStyle(fontSize: 24)),
                  title: Text(opt['label']!),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _currentLang = opt['code']!;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _handleLogin() {
    // Navigue vers la page sidebar après connexion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SidebarPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _currentLang == 'ar';
    final texts = languages[_currentLang]!;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        // Fond de page vert clair
        backgroundColor: loginGreen,
        appBar: AppBar(
          backgroundColor: loginGreen,
          elevation: 0,
          toolbarHeight: 90,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text(
              'BASSIANA',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 42,
                letterSpacing: 1.5,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            // Bouton de sélection de langue (indépendant du bouton login)
            IconButton(
              icon: const Icon(Icons.language, color: Colors.black87),
              tooltip: 'Changer de langue',
              onPressed: _showLanguagePicker,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                texts['hello']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // Label email
              Text(
                texts['email']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Rectangle (champ de texte) pour l'email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: texts['email'],
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Label mot de passe
              Text(
                texts['password']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Rectangle (champ de texte) pour le mot de passe
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: texts['password'],
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bouton login (sans bouton de langue à côté)
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  texts['login']!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}