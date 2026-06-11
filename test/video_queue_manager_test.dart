import 'package:flutter_test/flutter_test.dart';
import 'package:psl_translator/services/video_queue_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VideoQueueManager idle configuration', () {
    test('exposes idle video asset path', () {
      expect(
        VideoQueueManager.idleVideoAsset,
        'assets/sign_videos/idle.mp4',
      );
    });

    test('starts with no translation queue', () {
      final manager = VideoQueueManager();
      expect(manager.hasQueue, isFalse);
      expect(manager.queue, isEmpty);
      manager.dispose();
    });
  });
}
