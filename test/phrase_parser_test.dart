import 'package:flutter_test/flutter_test.dart';
import 'package:psl_translator/services/phrase_alias_dictionary.dart';
import 'package:psl_translator/services/phrase_parser.dart';
import 'package:psl_translator/services/phrase_queue_manager.dart';

void main() {
  final parser = PhraseParser();
  final queueManager = PhraseQueueManager(phraseParser: parser);

  group('PhraseAliasDictionary.normalizeText', () {
    test('normalizes case, punctuation, and whitespace', () {
      expect(PhraseAliasDictionary.normalizeText('Hello'), 'hello');
      expect(PhraseAliasDictionary.normalizeText('HELLO'), 'hello');
      expect(PhraseAliasDictionary.normalizeText('hello!'), 'hello');
      expect(PhraseAliasDictionary.normalizeText('  hello   '), 'hello');
    });
  });

  group('PhraseParser speech aliases', () {
    test('"hi" maps to hello', () {
      expect(parser.parse('hi'), ['hello']);
      expect(
        queueManager.buildFromSpeech('hi'),
        ['assets/sign_videos/hello.mp4'],
      );
    });

    test('"assalam u alaikum" maps to hello', () {
      expect(parser.parse('assalam u alaikum'), ['hello']);
      expect(
        queueManager.buildFromSpeech('assalam u alaikum'),
        ['assets/sign_videos/hello.mp4'],
      );
    });
  });

  group('PhraseParser multi-phrase detection', () {
    test('"hello how are you" preserves phrase order', () {
      expect(parser.parse('hello how are you'), ['hello', 'how_are_you']);
      expect(
        queueManager.buildFromSpeech('hello how are you'),
        [
          'assets/sign_videos/hello.mp4',
          'assets/sign_videos/how_are_you.mp4',
        ],
      );
    });
  });
}
