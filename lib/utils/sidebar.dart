import 'package:flutter/material.dart';
import '../pages/page1.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int _selectedIndex = 0;

  // Largeur de la sidebar
  static const double _collapsedWidth = 16; // bord discret visible au repos
  double _width = _collapsedWidth;
  Duration _animDuration = Duration.zero;
  bool _isOpen = false;

  final List<String> _titles = [
    'Home',
    'New observation',
    'Result',
    'History',
    'Profile',
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.add_box,
    Icons.insights,
    Icons.history,
    Icons.person,
  ];

  void _onDragStart(DragStartDetails details) {
    setState(() => _animDuration = Duration.zero);
  }

  void _onDragUpdate(DragUpdateDetails details, double openWidth) {
    setState(() {
      _width = (_width + details.delta.dx).clamp(_collapsedWidth, openWidth);
    });
  }

  void _onDragEnd(DragEndDetails details, double openWidth) {
    setState(() {
      _animDuration = const Duration(milliseconds: 220);
      if (_width > openWidth / 2) {
        _width = openWidth;
        _isOpen = true;
      } else {
        _width = _collapsedWidth;
        _isOpen = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double openWidth = screenWidth / 2;
    final double opacityFactor =
    ((_width - _collapsedWidth) / (openWidth - _collapsedWidth)).clamp(0.0, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          // ===== Contenu principal (toujours plein écran) =====
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: Colors.white,
                child: Text(
                  _titles[_selectedIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Center(
                  child: Text(
                    _selectedIndex == 1
                        ? "Bienvenue ! Vous êtes connecté."
                        : "Section : ${_titles[_selectedIndex]}",
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),

          // ===== Sidebar (par-dessus le contenu, glisse depuis le bord gauche) =====
          AnimatedContainer(
            duration: _animDuration,
            width: _width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[50],
              boxShadow: _isOpen || _width > _collapsedWidth
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(2, 0),
                ),
              ]
                  : [],
            ),
            child: GestureDetector(
              onHorizontalDragStart: _onDragStart,
              onHorizontalDragUpdate: (d) => _onDragUpdate(d, openWidth),
              onHorizontalDragEnd: (d) => _onDragEnd(d, openWidth),
              behavior: HitTestBehavior.translucent,
              child: ClipRect(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // ===== Liste des éléments =====
                    Expanded(
                      child: ListView.builder(
                        itemCount: _titles.length,
                        itemBuilder: (context, index) {
                          final bool selected = index == _selectedIndex;
                          return InkWell(
                            onTap: () {
                              setState(() => _selectedIndex = index);
                            },
                            child: Container(
                              color: selected
                                  ? Colors.green[200]
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    _icons[index],
                                    color: selected
                                        ? Colors.green[900]
                                        : Colors.black54,
                                  ),
                                  const SizedBox(width: 16),
                                  Opacity(
                                    opacity: opacityFactor,
                                    child: Text(
                                      _titles[index],
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selected
                                            ? Colors.green[900]
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // ===== Bouton déconnexion en bas =====
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.logout, color: Colors.red),
                            tooltip: 'Déconnexion',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const page1(),
                                ),
                              );
                            },
                          ),
                          Opacity(
                            opacity: opacityFactor,
                            child: const Text(
                              'Déconnexion',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}