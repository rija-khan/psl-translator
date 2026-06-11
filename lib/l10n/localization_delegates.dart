import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

/// Framework locales that lack first-party Material/Cupertino/Widgets support.
const _frameworkFallbackLanguages = {'sd', 'pa', 'ps'};

Locale _materialLocaleFor(Locale locale) {
  if (_frameworkFallbackLanguages.contains(locale.languageCode)) {
    return const Locale('ur');
  }
  return locale;
}

Locale _cupertinoLocaleFor(Locale locale) {
  if (_frameworkFallbackLanguages.contains(locale.languageCode)) {
    return const Locale('en');
  }
  return locale;
}

Locale _widgetsLocaleFor(Locale locale) {
  if (_frameworkFallbackLanguages.contains(locale.languageCode)) {
    return const Locale('ur');
  }
  return locale;
}

class AppMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const AppMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return GlobalMaterialLocalizations.delegate
        .load(_materialLocaleFor(locale));
  }

  @override
  bool shouldReload(AppMaterialLocalizationsDelegate old) => false;
}

class AppCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const AppCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return GlobalCupertinoLocalizations.delegate
        .load(_cupertinoLocaleFor(locale));
  }

  @override
  bool shouldReload(AppCupertinoLocalizationsDelegate old) => false;
}

class AppWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const AppWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    return GlobalWidgetsLocalizations.delegate.load(_widgetsLocaleFor(locale));
  }

  @override
  bool shouldReload(AppWidgetsLocalizationsDelegate old) => false;
}

/// App content + framework localization delegates.
const List<LocalizationsDelegate<dynamic>> appLocalizationDelegates =
    <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  AppMaterialLocalizationsDelegate(),
  AppCupertinoLocalizationsDelegate(),
  AppWidgetsLocalizationsDelegate(),
];

Locale? resolveAppLocale(Locale? locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.first;
  }
  for (final supported in supportedLocales) {
    if (supported.languageCode == locale.languageCode) {
      return supported;
    }
  }
  return supportedLocales.first;
}
