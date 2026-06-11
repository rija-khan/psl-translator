import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    required this.locale,
    required this.onLocaleChanged,
    super.key,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languages = <String, String>{
      'en': l10n.languageEnglish,
      'ur': l10n.languageUrdu,
      'sd': l10n.languageSindhi,
      'pa': l10n.languagePunjabi,
      'ps': l10n.languagePashto,
    };
    final selectedCode =
        languages.containsKey(locale.languageCode) ? locale.languageCode : 'en';
    final selectedLanguage = languages[selectedCode]!;

    return PopupMenuButton<String>(
      tooltip: l10n.language,
      initialValue: selectedCode,
      onSelected: (code) => onLocaleChanged(Locale(code)),
      itemBuilder: (context) => languages.entries
          .map(
            (entry) => PopupMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            ),
          )
          .toList(),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 14, color: Color(0xFF10B981)),
            const SizedBox(width: 7),
            Text(
              selectedLanguage,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF111827)),
          ],
        ),
      ),
    );
  }
}
