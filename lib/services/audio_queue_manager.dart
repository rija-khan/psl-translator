import 'package:flutter/foundation.dart';

class AudioQueueManager extends ChangeNotifier {
  static const Set<String> supportedLanguages = {
    'english',
    'urdu',
    'sindhi',
    'punjabi',
    'pushto',
  };

  static const Map<String, String> _phraseFolders = {
    'hello': 'hello',
    'i_am_a_student': 'I_am_a_student',
    'how_are_you': 'how_are_you',
    'are_you_deaf': 'are_you_deaf',
  };

  final List<String> _audioQueue = <String>[];

  List<String> get audioQueue => List.unmodifiable(_audioQueue);
  bool get hasAudio => _audioQueue.isNotEmpty;

  List<String> buildAudioQueue({
    required List<String> phrases,
    required String language,
  }) {
    final normalizedLanguage = supportedLanguages.contains(language)
        ? language
        : 'english';

    _audioQueue
      ..clear()
      ..addAll(
        phrases.map((phrase) {
          final folder = _phraseFolders[phrase];
          if (folder == null) return null;
          return 'assets/audio/$folder/${folder}_$normalizedLanguage.mp3';
        }).whereType<String>(),
      );

    debugPrint('Generated audio queue: $_audioQueue');
    notifyListeners();
    return audioQueue;
  }

  void clear() {
    _audioQueue.clear();
    notifyListeners();
  }
}
