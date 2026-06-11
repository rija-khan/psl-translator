class PhraseAliasDictionary {
  PhraseAliasDictionary._();

  static const Map<String, List<String>> phraseAliases = {
    'hello': [
      'hello',
      'hi',
      'assalam u alaikum',
      'assalamualaikum',
      'salam',
    ],
    'how_are_you': [
      'how are you',
      'aap kaise hain',
      'kia haal hai',
      'tuhan kain ahiyo',
      'tusi kive o',
      'taso tsanga yaast',
    ],
    'i_am_a_student': [
      'i am a student',
      'mein ek student hu',
      'maan hik shagird ahiyan',
      'main ik talib ilm haan',
      'za yo zda koonki yam',
    ],
    'are_you_deaf': [
      'are you deaf',
      'kya aap behre hain',
      'cha tuhan boodra ahiyo',
      'ki tusi behre o',
      'aya taso kaan yaast',
    ],
  };

  static String normalizeText(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static List<String> tokenize(String input) {
    final normalized = normalizeText(input);
    if (normalized.isEmpty) return const [];
    return normalized.split(' ');
  }
}
