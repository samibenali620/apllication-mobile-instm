// lib/pages/language_service.dart
import 'package:flutter/material.dart';
import 'languages.dart';

/// Service global qui garde la langue courante et notifie l'app
/// quand elle change, pour que tous les widgets se reconstruisent.
class LanguageService extends ChangeNotifier {
  LanguageService._internal();
  static final LanguageService instance = LanguageService._internal();

  String _currentLang = 'fr'; // langue par défaut

  String get currentLang => _currentLang;

  bool get isRtl => _currentLang == 'ar';

  void setLanguage(String langCode) {
    if (!languages.containsKey(langCode)) return;
    if (_currentLang == langCode) return;
    _currentLang = langCode;
    notifyListeners();
  }

  /// Traduit une clé. Si la clé est absente dans la langue courante,
  /// retombe sur le français, puis affiche la clé elle-même en dernier recours
  /// (utile en dev pour repérer les clés manquantes).
  String translate(String key) {
    return languages[_currentLang]?[key] ??
        languages['fr']?[key] ??
        key;
  }
}

/// Permet d'écrire `context.tr('nav_home')` directement dans les widgets.
extension TranslationExtension on BuildContext {
  String tr(String key) {
    // On écoute LanguageService via un InheritedNotifier placé en haut de l'app
    // (voir LanguageScope ci-dessous) pour que le widget se reconstruise
    // automatiquement quand la langue change.
    LanguageScope.of(this); // force la dépendance / reconstruction
    return LanguageService.instance.translate(key);
  }
}

/// À placer une seule fois, au-dessus de MaterialApp (voir exemple dans main.dart),
/// pour que context.tr() reconstruise les widgets à chaque changement de langue.
class LanguageScope extends InheritedNotifier<LanguageService> {
  LanguageScope({super.key, required super.child})
      : super(notifier: LanguageService.instance);

  static LanguageService of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope introuvable : enveloppe ton MaterialApp avec <LanguageScope>');
    return scope!.notifier!;
  }
}