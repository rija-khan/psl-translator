import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psl_translator/l10n/app_localizations.dart';
import 'package:psl_translator/l10n/localization_delegates.dart';
import 'package:psl_translator/screens/home_screen.dart';
import 'package:psl_translator/screens/learn_screen.dart';
import 'package:psl_translator/screens/sign_screen.dart';
import 'package:psl_translator/screens/speak_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sindhi localization', () {
    test('AppLocalizationsSd loads all core keys', () {
      final l10n = lookupAppLocalizations(const Locale('sd'));
      expect(l10n.appName, isNotEmpty);
      expect(l10n.homeTagline, isNotEmpty);
      expect(l10n.lessonsCompleted(2, 10), contains('2'));
      expect(l10n.completedCount(1, 5), contains('1'));
      expect(l10n.timeSpent('30 min'), contains('30 min'));
      expect(l10n.lessonProgress(1, 8), contains('1'));
      expect(l10n.percentComplete(50), contains('50'));
    });

    testWidgets('HomeScreen renders in Sindhi without framework locale warnings',
        (tester) async {
      await tester.pumpWidget(
        const _LocalizedApp(home: _ScaffoldHome()),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.textContaining('پي ايس ايل'), findsOneWidget);
    });

    testWidgets('SpeakScreen renders in Sindhi without framework locale warnings',
        (tester) async {
      await tester.pumpWidget(
        const _LocalizedApp(home: SpeakScreen()),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('SignScreen renders in Sindhi without framework locale warnings',
        (tester) async {
      await tester.pumpWidget(
        const _LocalizedApp(home: Scaffold(body: SignScreen())),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('LearnScreen renders in Sindhi without framework locale warnings',
        (tester) async {
      await tester.pumpWidget(
        _LocalizedApp(
          home: LearnScreen(onOpenLesson: (_, __, ___) {}),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}

class _ScaffoldHome extends StatelessWidget {
  const _ScaffoldHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(onNavigate: (_) {}),
    );
  }
}

class _LocalizedApp extends StatelessWidget {
  const _LocalizedApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('sd'),
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
      localizationsDelegates: appLocalizationDelegates,
      home: home,
    );
  }
}
