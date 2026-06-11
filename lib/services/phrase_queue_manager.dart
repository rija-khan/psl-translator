import 'package:flutter/foundation.dart';

import 'phrase_parser.dart';

class PhraseQueueManager extends ChangeNotifier {
  PhraseQueueManager({PhraseParser? phraseParser})
      : _phraseParser = phraseParser ?? PhraseParser();

  static const Map<String, String> phraseToVideoAsset = {
    PhraseParser.hello: 'assets/sign_videos/hello.mp4',
    PhraseParser.howAreYou: 'assets/sign_videos/how_are_you.mp4',
    PhraseParser.iAmAStudent: 'assets/sign_videos/I_am_a_student.mp4',
    PhraseParser.areYouDeaf: 'assets/sign_videos/are_you_deaf.mp4',
  };

  final PhraseParser _phraseParser;
  final List<String> _phraseQueue = <String>[];
  final List<String> _videoQueue = <String>[];

  List<String> get phraseQueue => List.unmodifiable(_phraseQueue);
  List<String> get videoQueue => List.unmodifiable(_videoQueue);
  bool get hasVideos => _videoQueue.isNotEmpty;

  List<String> buildFromSpeech(String speechText) {
    final phrases = _phraseParser.parse(speechText);
    setPhrases(phrases);
    debugPrint('Generated video queue: $_videoQueue');
    return videoQueue;
  }

  void setPhrases(List<String> phrases) {
    _phraseQueue
      ..clear()
      ..addAll(phrases.where(phraseToVideoAsset.containsKey));

    _videoQueue
      ..clear()
      ..addAll(_phraseQueue.map((phrase) => phraseToVideoAsset[phrase]!));

    notifyListeners();
  }

  void clear() {
    _phraseQueue.clear();
    _videoQueue.clear();
    notifyListeners();
  }
}
