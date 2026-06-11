import 'package:flutter/foundation.dart';

class GestureQueueManager extends ChangeNotifier {
  static const Map<String, String> gestureToPhrase = {
    'thumbs_up': 'hello',
    'victory': 'i_am_a_student',
    'open_palm': 'how_are_you',
    'fist': 'are_you_deaf',
  };

  final List<String> _phraseQueue = <String>[];

  List<String> get phraseQueue => List.unmodifiable(_phraseQueue);
  bool get hasPhrases => _phraseQueue.isNotEmpty;

  void addGesture(String gesture) {
    final phrase = gestureToPhrase[gesture];
    if (phrase == null) return;
    _phraseQueue.add(phrase);
    debugPrint('Detected gesture: $gesture');
    debugPrint('Sign phrase queue: $_phraseQueue');
    notifyListeners();
  }

  void setPhrases(List<String> phrases) {
    _phraseQueue
      ..clear()
      ..addAll(
        phrases.where((phrase) => gestureToPhrase.containsValue(phrase)),
      );
    debugPrint('Sign phrase queue: $_phraseQueue');
    notifyListeners();
  }

  void clear() {
    _phraseQueue.clear();
    notifyListeners();
  }
}
