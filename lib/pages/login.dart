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
          toolbarHeight: 120,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title:  Padding(
            padding:const EdgeInsets.only(top: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              const Text(
              'BASSIANA',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              texts['appSubtitle']!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
            ),
          ),
          actions: [
            ..._availableLanguages.map((opt) {
              final isSelected = _currentLang == opt['code'];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentLang = opt['code']!;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black87, width: 2)
                          : null,
                    ),
                    child: Text(
                      opt['flag']!,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
          body: Column(
            children: [
            // Zone verte du haut (vide, juste pour l'espace visuel)
              Expanded(
                flex: 22, // ajuste ce chiffre pour plus/moins de vert
                child: Container(
                  width: double.infinity,
                  color: loginGreen,
                ),
              ),
          Expanded(
            flex:68,
            child: Container(
              color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                texts['welcome back']!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                texts['subtitle']!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  texts['forgotPassword']!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bouton login
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  texts['login']!,
                  style: const TextStyle(fontSize: 16),

                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  texts['needHelp']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    ],
          ),
      ),
    );
  }
}