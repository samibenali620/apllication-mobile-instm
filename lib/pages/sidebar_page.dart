import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'login.dart';
import '../main.dart'; // fournit teaGreen
import '../widgets/app_scrollbar.dart';
import '../widgets/app_button.dart';
import '../services/weatherservice.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/adaptive_scroll_view.dart';
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
    AppScrollbar(
      builder: (context, controller) => SingleChildScrollView(
        controller: controller,
        child: const _HomeHeader(),
      ),
    ),
    const _NewObservationPage(),
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
              child: AppScrollbar(
                builder: (context, controller) => ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(LucideIcons.home,
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
                    leading: Icon(LucideIcons.plus,
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
                    leading: Icon(LucideIcons.clipboardCheck,
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
                    leading: Icon(LucideIcons.history,
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
                    leading: Icon(LucideIcons.user,
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
            ),
            // Bouton de déconnexion collé en bas du sidebar
            const Divider(height: 1, color: Colors.black26),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: AppButton(
                  label: 'Déconnexion',
                  icon: LucideIcons.logOut,
                  variant: AppButtonVariant.danger,
                  onPressed: _handleLogout,
                ),
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
                    icon: Icon(LucideIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.plus),
                    label: 'Observe',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.clipboardCheck),
                    label: 'Result',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.history),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.user),
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
    return AppScrollbar(
      builder: (context, controller) => ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      children: [
        // Nom + photo de profil + email (nom au-dessus de la photo)
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: teaGreen,
                child: Icon(LucideIcons.user, size: 55, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              TextButton.icon(
                onPressed: () {
                  // TODO: brancher la sélection/upload de photo
                },
                icon: const Icon(LucideIcons.camera, size: 16),
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
                leading: Icon(LucideIcons.phone),
                title: Text('Téléphone'),
                subtitle: Text('+216 00 000 000'),
              ),
              Divider(height: 1),
              ListTile(
                dense: true,
                leading: Icon(LucideIcons.mapPin),
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
                leading: const Icon(LucideIcons.squarePen),
                title: const Text('Modifier le profil'),
                trailing: const Icon(LucideIcons.chevronRight),
                onTap: () {
                  // TODO: naviguer vers l'écran de modification de profil
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(LucideIcons.lockKeyhole),
                title: const Text('Changer le mot de passe'),
                trailing: const Icon(LucideIcons.chevronRight),
                onTap: () {
                  // TODO: naviguer vers l'écran de changement de mot de passe
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(LucideIcons.languages),
                title: const Text('Langue'),
                trailing: const Icon(LucideIcons.chevronRight),
                onTap: () {
                  // TODO: ouvrir le sélecteur de langue
                },
              ),
              const Divider(height: 1),
              ListTile(
                dense: true,
                leading: const Icon(LucideIcons.info),
                title: const Text('À propos de Bassiana'),
                trailing: const Icon(LucideIcons.chevronRight),
                onTap: () {
                  // TODO: afficher les infos de l'application
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Déconnexion
        AppButton(
          label: 'Déconnexion',
          icon: LucideIcons.logOut,
          variant: AppButtonVariant.danger,
          onPressed: onLogout,
        ),
      ],
      ),
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
          child: AppScrollbar(
            builder: (context, controller) => ListView(
            controller: controller,
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
            const Icon(LucideIcons.chevronDown, size: 18),
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
class _HomeHeader extends StatefulWidget {
  const _HomeHeader();

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weather;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final data = await _weatherService.fetchForecast(city: 'Tunis');
      setState(() {
        _weather = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

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
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            _greeting(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(LucideIcons.mapPin, size: 16, color: Colors.black54),
              SizedBox(width: 4),
              Text(
                'Tunis, Tunisie',
                style: TextStyle(fontSize: 13, color: Colors.black54),
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
            child: _loading
                ? const SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
                : _error != null
                ? SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Weather unavailable',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            )
                : Column(
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
                  children: [
                    Text(
                      '${_weather!.currentTempC.round()}°',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _weather!.conditionText,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(height: 1, color: Colors.white30),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(LucideIcons.droplet,
                        size: 15, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      '${_weather!.humidity}%',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.white70),
                    ),
                    const SizedBox(width: 16),
                    const Icon(LucideIcons.wind,
                        size: 15, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      '${_weather!.windKph.round()} km/h',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _weather!.forecast.map((f) {
                    return _ForecastDay(
                      day: f.dayName,
                      iconUrl: f.iconUrl,
                      temp: '${f.maxTempC.round()}°',
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _TodayAdviceBox(),
          const SizedBox(height: 14),
          const _NewObservationBox(),
          const SizedBox(height: 14),
          const _YourFieldBox(),
        ],
      ),
    );
  }
}
class _ForecastDay extends StatelessWidget {
  final String day;
  final String iconUrl;
  final String temp;

  const _ForecastDay({
    required this.day,
    required this.iconUrl,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 6),
        Image.network(iconUrl, width: 24, height: 24),
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
  const _TodayAdviceBox();

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
              LucideIcons.droplet,
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
                      Icon(LucideIcons.arrowRight, size: 16, color: Colors.orange),
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
class _NewObservationBox extends StatelessWidget {
  const _NewObservationBox();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: const [
              Text(
                'New Observation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Log today's field data for fresh advice",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Carré "Your Field" : titre, nom du plot, dernière vérification,
// séparateur, statut d'humidité (orange) et pourcentage en haut à droite.
class _YourFieldBox extends StatelessWidget {
  const _YourFieldBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Field',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Plot A – Olive Grove',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Last checked 2 days ago',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Icon(LucideIcons.droplet, size: 18, color: Colors.orange),
                  SizedBox(width: 6),
                  Text(
                    'Moisture – Low',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Text(
              '38%',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Page "Nouvelle Observation" : sélection du plot avec navigation gauche/droite.
class _NewObservationPage extends StatefulWidget {
  const _NewObservationPage();

  @override
  State<_NewObservationPage> createState() => _NewObservationPageState();
}

class _NewObservationPageState extends State<_NewObservationPage> {
  final List<String> _plots = ['Plot A – Olive', 'Plot B – Wheat', 'Plot C – Citrus'];
  int _selectedIndex = 0;

  final List<String> _crops = ['Olive', 'Wheat', 'Citrus', 'Tomato'];
  int _selectedCropIndex = 0;
  // ── Soil type ──
  final List<String> _soilTypes = ['Sandy', 'Loamy', 'Clay'];
  int _selectedSoilTypeIndex = 0;

// ── Field size ──
  double _fieldSize = 3.2;

  // 👉 COLLE ICI ton bloc :
  // ── Photo ──
  File? _selectedPhoto;
  // ── Notes ──
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _selectedPhoto = File(picked.path);
      });
    }
  }


  void _goLeft() {
    if (_selectedIndex > 0) {
      setState(() => _selectedIndex--);
    }
  }

  void _goRight() {
    if (_selectedIndex < _plots.length - 1) {
      setState(() => _selectedIndex++);
    }
  }
  // Soil moisture (0.0 = Dry, 1.0 = Wet)
  double _soilMoisture = 0.32;

  String get _moistureLabel {
    if (_soilMoisture < 0.35) return 'Low';
    if (_soilMoisture < 0.65) return 'Medium';
    return 'High';
  }

  Color get _moistureColor {
    if (_soilMoisture < 0.35) return Colors.orange.shade700;
    if (_soilMoisture < 0.65) return Colors.amber.shade700;
    return Colors.green.shade700;
  }
  Widget _buildCropBox(int index) {
    final isSelected = index == _selectedCropIndex;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedCropIndex = index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.green.shade900 : Colors.black12,
            ),
          ),
          child: Text(
            _crops[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSoilTypeBox(int index) {
    final isSelected = index == _selectedSoilTypeIndex;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedSoilTypeIndex = index),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? Colors.green.shade900 : Colors.black12,
            ),
          ),
          child: Text(
            _soilTypes[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollView (
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec logo de localisation
          Row(
            children: const [
              Icon(LucideIcons.mapPin, size: 20, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                'Which plot?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Les 3 petits carrés de sélection
          Row(
            children: List.generate(_plots.length, (index) {
              final isSelected = index == _selectedIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index != _plots.length - 1 ? 10 : 0,
                  ),
                  child: InkWell(
                    onTap: () => setState(() => _selectedIndex = index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.green.shade900 : Colors.black12,
                        ),
                      ),
                      child: Text(
                        _plots[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          // Flèches de navigation gauche / droite
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _selectedIndex > 0 ? _goLeft : null,
                icon: const Icon(LucideIcons.chevronLeft),
                color: Colors.black87,
                disabledColor: Colors.black26,
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: _selectedIndex < _plots.length - 1 ? _goRight : null,
                icon: const Icon(LucideIcons.chevronRight),
                color: Colors.black87,
                disabledColor: Colors.black26,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Titre avec logo de plante
          Row(
            children: const [
              Icon(LucideIcons.sprout, size: 20, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                'Crop Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Première ligne : Olive, Wheat
          Row(
            children: [
              _buildCropBox(0),
              const SizedBox(width: 10),
              _buildCropBox(1),
            ],
          ),
          const SizedBox(height: 10),

          // Deuxième ligne : Citrus, Tomato
          Row(
            children: [
              _buildCropBox(2),
              const SizedBox(width: 10),
              _buildCropBox(3),
            ],
          ),
          const SizedBox(height: 28),

// ── Soil moisture ────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.droplet, size: 18, color: Colors.black87),
                    const SizedBox(width: 8),
                    const Text(
                      'Soil moisture',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$_moistureLabel · ${(_soilMoisture * 100).round()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _moistureColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    thumbColor: Colors.white,
                    overlayColor: Colors.orange.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: _soilMoisture,
                    onChanged: (v) => setState(() => _soilMoisture = v),
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
                // Gradient track
                Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE53935), // rouge
                        Color(0xFFFB8C00), // orange
                        Color(0xFFFDD835), // jaune
                        Color(0xFF43A047), // vert
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dry', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      Text('Wet', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 28),

// ── Soil type ────────────────────────────────────────────
        Row(
          children: const [
            Icon(LucideIcons.layers, size: 20, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              'Soil type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSoilTypeBox(0),
            const SizedBox(width: 10),
            _buildSoilTypeBox(1),
            const SizedBox(width: 10),
            _buildSoilTypeBox(2),
          ],
        ),
        const SizedBox(height: 28),

// ── Field size ───────────────────────────────────────────
        Row(
          children: [
            const Icon(LucideIcons.frame, size: 20, color: Colors.black87),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Field size (ha)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _fieldSize = (_fieldSize - 0.1).clamp(0.0, 999.0);
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.remove, size: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _fieldSize.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                setState(() {
                  _fieldSize = (_fieldSize + 0.1).clamp(0.0, 999.0);
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
          const SizedBox(height: 28),

// ── Add a photo ─────────────────────────────────────────
          Row(
            children: const [
              Icon(LucideIcons.camera, size: 20, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                'Add a photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '(optional)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _pickPhoto,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.green.shade200,
                  width: 1.2,
                ),
              ),
              child: _selectedPhoto == null
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.camera,
                      size: 32,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tap to take or upload a photo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  _selectedPhoto!,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

// ── Notes ────────────────────────────────────────────────
          Row(
            children: const [
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '(optional)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Anything else to mention?',
                hintStyle: TextStyle(color: Colors.black38),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

// ── Analyze button ───────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: lancer l'analyse avec toutes les données collectées
                // plot: _plots[_selectedIndex]
                // crop: _crops[_selectedCropIndex]
                // moisture: _soilMoisture
                // soilType: _soilTypes[_selectedSoilTypeIndex]
                // fieldSize: _fieldSize
                // photo: _selectedPhoto
                // notes: _notesController.text
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Analyze & Get Advice',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    ],
      ),
    );
  }
}

