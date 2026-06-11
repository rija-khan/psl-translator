import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'l10n/localization_delegates.dart';

import 'models/lesson.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/sign_screen.dart';
import 'screens/speak_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/language_selector.dart';

class PslTranslatorApp extends StatefulWidget {
  const PslTranslatorApp({super.key});

  @override
  State<PslTranslatorApp> createState() => _PslTranslatorAppState();
}

class _PslTranslatorAppState extends State<PslTranslatorApp> {
  final AuthService _authService = AuthService();
  Locale _locale = const Locale('en');
  bool? _isAuthenticated;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final hasSession = await _authService.hasValidSession();
    if (!mounted) return;
    setState(() => _isAuthenticated = hasSession);
  }

  void _setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  void _setAuthenticated(bool value) {
    setState(() => _isAuthenticated = value);
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = _isAuthenticated;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      theme: AppTheme.light(),
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
      localizationsDelegates: appLocalizationDelegates,
      home: isAuthenticated == null
          ? const _StartupScreen()
          : isAuthenticated
              ? AppShell(
                  authService: _authService,
                  locale: _locale,
                  onLocaleChanged: _setLocale,
                  onSignedOut: () => _setAuthenticated(false),
                )
              : LoginScreen(
                  authService: _authService,
                  onAuthenticated: () => _setAuthenticated(true),
                ),
    );
  }
}

class _StartupScreen extends StatelessWidget {
  const _StartupScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({
    required this.authService,
    required this.locale,
    required this.onLocaleChanged,
    required this.onSignedOut,
    super.key,
  });

  final AuthService authService;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onSignedOut;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _openLesson(BuildContext context, List<Lesson> lessons, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonScreen(lessons: lessons, initialIndex: index),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          authService: widget.authService,
          onSignedOut: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            widget.onSignedOut();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = <Widget>[
      HomeScreen(onNavigate: (index) => setState(() => _selectedIndex = index)),
      const SpeakScreen(),
      const SignScreen(),
      LearnScreen(onOpenLesson: _openLesson),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        titleSpacing: 15,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sign_language, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                l10n.appName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        actions: [
          LanguageSelector(
            locale: widget.locale,
            onLocaleChanged: widget.onLocaleChanged,
          ),
          const SizedBox(width: 6),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            height: 52,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE5E7EB)),
                bottom: BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ModeTab(
                    icon: Icons.mic,
                    label: l10n.speakMode,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                ),
                Expanded(
                  child: _ModeTab(
                    icon: Icons.sign_language,
                    label: l10n.signMode,
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: PslBottomNavigation(
        selectedIndex: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        onSettings: _openSettings,
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF6B7280), size: 15),
            const SizedBox(width: 5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
