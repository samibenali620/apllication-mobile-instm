import 'package:flutter/material.dart';

class SidebarPage extends StatelessWidget {
  const SidebarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Déconnexion'),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bienvenue sur la page principale',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}