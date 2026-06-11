class SignSpeechTranslationDictionary {
  SignSpeechTranslationDictionary._();

  static const Set<String> supportedLanguages = {'en', 'ur', 'sd', 'pa', 'ps'};

  static const Map<String, Map<String, String>> translations = {
    'hello': {
      'en': 'Assalam u Alaikum',
      'ur': 'السلام علیکم',
      'sd': 'السلام عليڪم',
      'pa': 'السلام علیکم',
      'ps': 'السلام علیکم',
    },
    'how_are_you': {
      'en': 'How are you?',
      'ur': 'آپ کیسے ہیں؟',
      'sd': 'توھان ڪيئن آھيو؟',
      'pa': 'تسی کیسے او؟',
      'ps': 'تاسو څنګه یاست؟',
    },
    'i_am_a_student': {
      'en': 'I am a student.',
      'ur': 'میں ایک طالب علم ہوں۔',
      'sd': 'مان هڪ شاگرد آھيان۔',
      'pa': 'میں ایک طالب علم ہاں۔',
      'ps': 'زه یو زده کوونکی یم۔',
    },
    'are_you_deaf': {
      'en': 'Are you deaf?',
      'ur': 'کیا آپ بہرے ہیں؟',
      'sd': 'ڇا توھان ٻوڙا آھيو؟',
      'pa': 'کیا تسی بہرے او؟',
      'ps': 'ایا تاسو کاڼ یاست؟',
    },
  };

  static String translate(String canonicalPhrase, String languageCode) {
    final normalizedLanguage =
        supportedLanguages.contains(languageCode) ? languageCode : 'en';
    return translations[canonicalPhrase]?[normalizedLanguage] ?? '';
  }

  static String formatPhrases(List<String> phrases, String languageCode) {
    return phrases
        .map((phrase) => translate(phrase, languageCode))
        .where((translation) => translation.isNotEmpty)
        .join('\n');
  }
}
