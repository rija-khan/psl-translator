import 'package:flutter_test/flutter_test.dart';
import 'package:psl_translator/services/gesture_queue_manager.dart';
import 'package:psl_translator/services/phrase_parser.dart';
import 'package:psl_translator/services/sign_speech_translation_dictionary.dart';

void main() {
  final parser = PhraseParser();
  final gestureQueue = GestureQueueManager();

  group('SignSpeechTranslationDictionary', () {
    test('hello in English', () {
      expect(
        SignSpeechTranslationDictionary.translate('hello', 'en'),
        'Assalam u Alaikum',
      );
    });

    test('hello in Urdu', () {
      expect(
        SignSpeechTranslationDictionary.translate('hello', 'ur'),
        'السلام علیکم',
      );
    });

    test('hello in Pashto', () {
      expect(
        SignSpeechTranslationDictionary.translate('hello', 'ps'),
        'السلام علیکم',
      );
    });
  });

  group('Gesture to translation', () {
    test('thumbs_up maps to hello translation', () {
      gestureQueue.clear();
      gestureQueue.addGesture('thumbs_up');
      expect(gestureQueue.phraseQueue, ['hello']);
      expect(
        SignSpeechTranslationDictionary.formatPhrases(
          gestureQueue.phraseQueue,
          'en',
        ),
        'Assalam u Alaikum',
      );
      expect(
        SignSpeechTranslationDictionary.formatPhrases(
          gestureQueue.phraseQueue,
          'ur',
        ),
        'السلام علیکم',
      );
    });
  });

  group('Text input matches gesture detection', () {
    test('typed hello resolves to same translation as thumbs_up', () {
      gestureQueue.clear();
      gestureQueue.addGesture('thumbs_up');
      final gestureTranslation = SignSpeechTranslationDictionary.formatPhrases(
        gestureQueue.phraseQueue,
        'en',
      );

      final textPhrases = parser.parse('hello');
      gestureQueue.setPhrases(textPhrases);
      final textTranslation = SignSpeechTranslationDictionary.formatPhrases(
        gestureQueue.phraseQueue,
        'en',
      );

      expect(textPhrases, ['hello']);
      expect(textTranslation, gestureTranslation);
      expect(textTranslation, 'Assalam u Alaikum');
    });
  });
}
