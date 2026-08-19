import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import '../main.dart'; // fournit teaGreen

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  // Index de la page actuellement sélectionnée
  int _selectedIndex = 0;

  // Titres correspondant à chaque page (affichés dans l'AppBar)
  final List<String> _titles = const [
    'Accueil',
    'Nouvelle Observation',
    'Résultat',
    'Historique',
    'Profil',
  ];

  // Contenu de chaque page (à remplacer plus tard par vos vraies pages)
  List<Widget> get _pages => [
    const Center(
      child: Text('Bienvenue sur la page principale',
          style: TextStyle(fontSize: 18)),
    ),
    const Center(
      child:
      Text('Page Nouvelle Observation', style: TextStyle(fontSize: 18)),
    ),
    const Center(
      child: Text('Page Résultat', style: TextStyle(fontSize: 18)),
    ),
    const Center(
      child: Text('Page Historique', style: TextStyle(fontSize: 18)),
    ),
    _ProfilePage(onLogout: _handleLogout),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Ferme le drawer après sélection
  }

  // Déconnexion : retourne à la page Login et vide la pile de navigation
  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: teaGreen,
        foregroundColor: Colors.black87,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        backgroundColor: teaGreen,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: teaGreen),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.black87),
                    title: const Text('Home',
                        style: TextStyle(color: Colors.black87)),
                    selected: _selectedIndex == 0,
                    onTap: () => _onItemSelected(0),
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.add_box, color: Colors.black87),
                    title: const Text('New Observation',
                        style: TextStyle(color: Colors.black87)),
                    selected: _selectedIndex == 1,
                    onTap: () => _onItemSelected(1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment_turned_in,
                        color: Colors.black87),
                    title: const Text('Result',
                        style: TextStyle(color: Colors.black87)),
                    selected: _selectedIndex == 2,
                    onTap: () => _onItemSelected(2),
                  ),
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.black87),
                    title: const Text('History',
                        style: TextStyle(color: Colors.black87)),
                    selected: _selectedIndex == 3,
                    onTap: () => _onItemSelected(3),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black87),
                    title: const Text('Profile',
                        style: TextStyle(color: Colors.black87)),
                    selected: _selectedIndex == 4,
                    onTap: () => _onItemSelected(4),
                  ),
                ],
              ),
            ),
            // Bouton de déconnexion collé en bas du sidebar
            const Divider(height: 1, color: Colors.black26),
            SafeArea(
              top: false,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: _handleLogout,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

// Page Profil : affiche les informations de l'utilisateur et les actions
// courantes (modifier profil, mot de passe, langue, à propos, déconnexion).
// À remplacer par de vraies données utilisateur (venant d'une API/BDD).
class _ProfilePage extends StatelessWidget {
  final VoidCallback onLogout;

  const _ProfilePage({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Photo de profil + nom + email
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: teaGreen,
                child: Icon(Icons.person, size: 60, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              TextButton.icon(
                onPressed: () {
                  // TODO: brancher la sélection/upload de photo
                },
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text('Changer la photo'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nom Utilisateur',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'utilisateur@email.com',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Informations personnelles
        Card(
          elevation: 0,
          color: teaGreen.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Téléphone'),
                subtitle: Text('+216 00 000 000'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Localisation'),
                subtitle: Text('Tunis, Tunisie'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Actions du compte
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Modifier le profil'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: naviguer vers l'écran de modification de profil
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock_outline),
          title: const Text('Changer le mot de passe'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: naviguer vers l'écran de changement de mot de passe
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Langue'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: ouvrir le sélecteur de langue
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('À propos de Bassiana'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: afficher les infos de l'application
          },
        ),
        const SizedBox(height: 20),

        // Déconnexion
        ElevatedButton.icon(
          onPressed: onLogout,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.logout),
          label: const Text('Déconnexion'),
        ),
      ],
    );
  }
}