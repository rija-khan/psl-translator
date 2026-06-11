import 'package:flutter/foundation.dart';

import 'phrase_alias_dictionary.dart';

class PhraseParser {
  static const String hello = 'hello';
  static const String howAreYou = 'how_are_you';
  static const String iAmAStudent = 'i_am_a_student';
  static const String areYouDeaf = 'are_you_deaf';

  static final List<_PhrasePattern> _patterns = _buildPatterns();

  static List<_PhrasePattern> _buildPatterns() {
    final patterns = <_PhrasePattern>[];

    for (final entry in PhraseAliasDictionary.phraseAliases.entries) {
      for (final alias in entry.value) {
        final words = PhraseAliasDictionary.tokenize(alias);
        if (words.isEmpty) continue;
        patterns.add(
          _PhrasePattern(
            canonicalPhrase: entry.key,
            spokenWords: words,
          ),
        );
      }
    }

    patterns.sort(
      (a, b) => b.spokenWords.length.compareTo(a.spokenWords.length),
    );
    return patterns;
  }

  List<String> parse(String speechText) {
    final words = PhraseAliasDictionary.tokenize(speechText);
    final detectedPhrases = <String>[];
    var index = 0;

    while (index < words.length) {
      final match = _findLongestMatch(words, index);
      if (match == null) {
        index++;
        continue;
      }

      detectedPhrases.add(match.canonicalPhrase);
      index += match.spokenWords.length;
    }

    debugPrint('Detected phrases: $detectedPhrases');
    return detectedPhrases;
  }

  _PhrasePattern? _findLongestMatch(List<String> words, int startIndex) {
    _PhrasePattern? bestMatch;

    for (final pattern in _patterns) {
      if (!_matches(words, startIndex, pattern.spokenWords)) continue;
      if (bestMatch == null ||
          pattern.spokenWords.length > bestMatch.spokenWords.length) {
        bestMatch = pattern;
      }
    }

    return bestMatch;
  }

  bool _matches(List<String> words, int startIndex, List<String> phraseWords) {
    if (startIndex + phraseWords.length > words.length) return false;

    for (var index = 0; index < phraseWords.length; index++) {
      if (words[startIndex + index] != phraseWords[index]) return false;
    }

    return true;
  }
}

class _PhrasePattern {
  const _PhrasePattern({
    required this.canonicalPhrase,
    required this.spokenWords,
  });

  final String canonicalPhrase;
  final List<String> spokenWords;
}
