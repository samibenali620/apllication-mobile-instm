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
    'Home',
    'Nouvelle Observation',
    'Résultat',
    'Historique',
    'Profil',
  ];

  // Contenu de chaque page (à remplacer plus tard par vos vraies pages)
  // To this:
  List<Widget> get _pages => [
    const SingleChildScrollView( // Remove "const" here!child:_HomeHeader(),
      child: _HomeHeader(),
    ),
    const Center(
      child: Text('Page Nouvelle Observation', style: TextStyle(fontSize: 18)),
    ),
    // ...
    const Center(
      child: Text('Page Résultat', style: TextStyle(fontSize: 18)),
    ),
    const _HistoryPage(),
    _ProfilePage(onLogout: _handleLogout),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Ferme le drawer après sélection
  }

  void _onFooterItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                    leading: Icon(Icons.home,
                        color: _selectedIndex == 0
                            ? Colors.green
                            : Colors.black87),
                    title: Text('Home',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Colors.green
                              : Colors.black87,
                          fontWeight: _selectedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    selected: _selectedIndex == 0,
                    selectedTileColor: Colors.white,
                    onTap: () => _onItemSelected(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_box,
                        color: _selectedIndex == 1
                            ? Colors.green
                            : Colors.black87),
                    title: Text('New Observation',
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? Colors.green
                              : Colors.black87,
                          fontWeight: _selectedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    selected: _selectedIndex == 1,
                    selectedTileColor: Colors.white,
                    onTap: () => _onItemSelected(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.assignment_turned_in,
                        color: _selectedIndex == 2
                            ? Colors.green
                            : Colors.black87),
                    title: Text('Result',
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Colors.green
                              : Colors.black87,
                          fontWeight: _selectedIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    selected: _selectedIndex == 2,
                    selectedTileColor: Colors.white,
                    onTap: () => _onItemSelected(2),
                  ),
                  ListTile(
                    leading: Icon(Icons.history,
                        color: _selectedIndex == 3
                            ? Colors.green
                            : Colors.black87),
                    title: Text('History',
                        style: TextStyle(
                          color: _selectedIndex == 3
                              ? Colors.green
                              : Colors.black87,
                          fontWeight: _selectedIndex == 3
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    selected: _selectedIndex == 3,
                    selectedTileColor: Colors.white,
                    onTap: () => _onItemSelected(3),
                  ),
                  ListTile(
                    leading: Icon(Icons.person,
                        color: _selectedIndex == 4
                            ? Colors.green
                            : Colors.black87),
                    title: Text('Profile',
                        style: TextStyle(
                          color: _selectedIndex == 4
                              ? Colors.green
                              : Colors.black87,
                          fontWeight: _selectedIndex == 4
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    selected: _selectedIndex == 4,
                    selectedTileColor: Colors.white,
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
            child: SizedBox(
              height: (_selectedIndex == 3 || _selectedIndex == 4) ? 72 : 56,
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onFooterItemTapped,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.black45,
                showUnselectedLabels: true,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box),
                    label: 'Observe',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment_turned_in),
                    label: 'Result',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profil',
                  ),
                ],
              ),
            )
        ),
      ),
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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      children: [
        // Nom + photo de profil + email (nom au-dessus de la photo)
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: teaGreen,
                child: Icon(Icons.person, size: 55, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              TextButton.icon(
                onPressed: () {
                  // TODO: brancher la sélection/upload de photo
                },
                icon: const Icon(Icons.camera_alt, size: 16),
                label: const Text('Changer la photo'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(height: 8),
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
        const SizedBox(height: 14),

        // Premier carré : informations personnelles (téléphone + localisation)
        Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.black12),
          ),
          child: Column(
            children: const [
              ListTile(
                dense: true,
                leading: Icon(Icons.phone),
                title: Text('Téléphone'),
                subtitle: Text('+216 00 000 000'),
              ),
              Divider(height: 1),
              ListTile(
                dense: true,
                leading: Icon(Icons.location_on),
                title: Text('Localisation'),
                subtitle: Text('Tunis, Tunisie'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Deuxième carré : actions du compte
        Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.black12),
          ),
          child: Column(
            children: [
              ListTile(
                dense: true,
                leading: const Icon(Icons.edit),
                title: const Text('Modifier le profil'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: naviguer vers l'écran de modification de profil
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(Icons.lock_outline),
                title: const Text('Changer le mot de passe'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: naviguer vers l'écran de changement de mot de passe
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(Icons.language),
                title: const Text('Langue'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: ouvrir le sélecteur de langue
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(Icons.info_outline),
                title: const Text('À propos de Bassiana'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: afficher les infos de l'application
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

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
// Page Historique : affiche des filtres (plantes / période) en haut,
// puis la liste de l'historique en dessous.
class _HistoryPage extends StatelessWidget {
  const _HistoryPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              _FilterBox(
                label: 'All plts',
                onTap: () {
                  // TODO: ouvrir le sélecteur de plantes
                },
              ),
              const SizedBox(width: 10),
              _FilterBox(
                label: 'Last 30 days',
                onTap: () {
                  // TODO: ouvrir le sélecteur de période
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(
            'August 2026',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              _PlotHistoryCard(
                title: 'Plot A – Olive Grove',
                subtitle: 'August 20, 2026',
                badgeLabel: 'Irrigate Now',
                badgeColor: Colors.red,
              ),
              _PlotHistoryCard(
                title: 'Plot B – Wheat Field',
                subtitle: 'August 14, 2026',
                badgeLabel: 'Good Conditions',
                badgeColor: Colors.green,
              ),
              _PlotHistoryCard(
                title: 'Plot C – Citrus',
                subtitle: 'August 6, 2026',
                badgeLabel: 'Sow Now',
                badgeColor: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  'July 2026',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _PlotHistoryCard(
                title: 'Plot A – Olive Grove',
                subtitle: 'Jul 29, 2026',
                badgeLabel: 'Irrigate Now',
                badgeColor: Colors.red,
              ),
              _PlotHistoryCard(
                title: 'Plot B – Wheat Field',
                subtitle: 'Jul 18, 2026',
                badgeLabel: 'Good Conditions',
                badgeColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Petit carré filtre réutilisable, avec libellé + flèche.
// Petit carré filtre réutilisable, avec libellé + flèche, et un sous-texte optionnel en dessous.
// Petit carré filtre réutilisable, avec libellé + flèche.
class _FilterBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterBox({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}
// Carte d'historique : titre (plot), sous-titre (date) et badge coloré.
class _PlotHistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeLabel;
  final Color badgeColor;

  const _PlotHistoryCard({
    required this.title,
    required this.subtitle,
    required this.badgeLabel,
    required this.badgeColor,
  }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badgeLabel,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// En-tête de la page Home : date du jour, salutation, localisation et météo.
class _HomeHeader extends StatelessWidget {
  const _HomeHeader();
  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  String _formattedDate() {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final now = DateTime.now();
    final dayName = days[now.weekday - 1];
    final monthName = months[now.month - 1];
    return '$dayName, $monthName ${now.day}, ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formattedDate(),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _greeting(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.location_on, size: 16, color: Colors.black54),
              SizedBox(width: 4),
              Text(
                'Tunis, Tunisie',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Carré vert météo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Weather",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          '28°',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sunny',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 1,
                      color: Colors.white30,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.water_drop, size: 15, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(
                          '65%',
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.air, size: 15, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(
                          '12 km/h',
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _ForecastDay(day: 'Thu', icon: Icons.wb_sunny, temp: '45°'),
                        _ForecastDay(day: 'Fri', icon: Icons.wb_sunny, temp: '43°'),
                        _ForecastDay(day: 'Sat', icon: Icons.wb_sunny, temp: '38°'),
                        _ForecastDay(day: 'Sun', icon: Icons.wb_sunny, temp: '41°'),
                        _ForecastDay(day: 'Mon', icon: Icons.wb_sunny, temp: '36°'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _TodayAdviceBox(),
        ],
      ),
    );
  }
}
class _ForecastDay extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temp;

  const _ForecastDay({
    required this.day,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 6),
        Icon(icon, size: 20, color: Colors.yellow),
        const SizedBox(height: 6),
        Text(
          temp,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
// Carré "Today's Advice" : conseil du jour avec icône pluie, titre,
// recommandation, texte explicatif et lien vers l'analyse complète.
// Carré "Today's Advice" : conseil du jour avec icône pluie, titre,
// recommandation, texte explicatif et lien vers l'analyse complète.
class _TodayAdviceBox extends StatelessWidget {
  const _TodayAdviceBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Advice",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Time to Irrigate',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Soil moisture is low, no rain expected for the next three days.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    // TODO: naviguer vers l'analyse complète
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'See full analysis',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}