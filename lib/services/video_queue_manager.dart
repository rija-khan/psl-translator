import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

enum VideoQueuePlaybackState {
  idle,
  loading,
  playing,
  paused,
  stopped,
  completed,
  error,
}

class VideoQueueManager extends ChangeNotifier {
  VideoQueueManager({
    List<String>? initialQueue,
    bool autoPlay = false,
    bool idleEnabled = true,
  }) : _idleEnabled = idleEnabled {
    if (initialQueue != null && initialQueue.isNotEmpty) {
      unawaited(setQueue(initialQueue, autoPlay: autoPlay));
    } else if (_idleEnabled) {
      unawaited(_returnToIdle());
    }
  }

  static const String idleVideoAsset = 'assets/sign_videos/idle.mp4';

  final List<String> _queue = <String>[];
  final List<String> _recentQueue = <String>[];

  VideoPlayerController? _translationController;
  VideoPlayerController? _idleController;
  VideoPlayerController? _nextController;
  String? _nextSource;
  int _currentIndex = -1;
  VideoQueuePlaybackState _state = VideoQueuePlaybackState.idle;
  Object? _error;
  bool _disposed = false;
  bool _isAdvancing = false;
  bool _isIdleMode = false;
  final bool _idleEnabled;

  List<String> get queue => List.unmodifiable(_queue);
  List<String> get recentQueue => List.unmodifiable(_recentQueue);
  int get currentIndex => _currentIndex;
  VideoQueuePlaybackState get state => _state;
  VideoPlayerController? get currentController =>
      _isIdleMode ? _idleController : _translationController;
  Object? get error => _error;
  bool get hasQueue => _queue.isNotEmpty;
  bool get isPlaying => _state == VideoQueuePlaybackState.playing;
  bool get isIdleMode => _isIdleMode;

  Future<void> setQueue(List<String> videos, {bool autoPlay = false}) async {
    final cleanQueue = videos.where((video) => video.trim().isNotEmpty).toList();
    debugPrint('VideoQueueManager received queue: $cleanQueue');

    if (cleanQueue.isEmpty) {
      await _returnToIdle();
      return;
    }

    await _pauseIdle();
    _isIdleMode = false;
    await _clearTranslationPlayback(disposeRecent: false);

    _queue
      ..clear()
      ..addAll(cleanQueue);
    _recentQueue
      ..clear()
      ..addAll(cleanQueue);
    _currentIndex = 0;
    _error = null;
    _state = VideoQueuePlaybackState.loading;
    _notify();

    try {
      await _loadCurrentController();
      await _preloadNextController();
      _state = VideoQueuePlaybackState.paused;
      _notify();
    } catch (error) {
      _error = error;
      _state = VideoQueuePlaybackState.error;
      debugPrint('VideoQueueManager failed to initialize queue: $error');
      _notify();
      return;
    }

    if (autoPlay) {
      await play();
    }
  }

  Future<void> play({List<String>? videos}) async {
    if (videos != null) {
      debugPrint('Starting playback: $videos');
      await setQueue(videos, autoPlay: true);
      return;
    }

    if (_isIdleMode) {
      if (_queue.isEmpty && _recentQueue.isNotEmpty) {
        await replay();
        return;
      }
      await _idleController?.play();
      _state = VideoQueuePlaybackState.playing;
      _notify();
      return;
    }

    if (_queue.isEmpty) {
      if (_recentQueue.isEmpty) {
        await _returnToIdle();
        return;
      }
      await replay();
      return;
    }

    if (_translationController == null) {
      if (_currentIndex < 0) _currentIndex = 0;
      await _loadCurrentController();
      await _preloadNextController();
    }

    await _translationController?.play();
    if (_currentIndex >= 0 && _currentIndex < _queue.length) {
      debugPrint('Current video: ${_queue[_currentIndex]}');
    }
    _state = VideoQueuePlaybackState.playing;
    _notify();
  }

  Future<void> pause() async {
    if (_isIdleMode) {
      await _idleController?.pause();
      _state = VideoQueuePlaybackState.paused;
      _notify();
      return;
    }

    await _translationController?.pause();
    if (_queue.isNotEmpty) {
      _state = VideoQueuePlaybackState.paused;
      _notify();
    }
  }

  Future<void> replay() async {
    if (_recentQueue.isEmpty) return;
    await _pauseIdle();
    _isIdleMode = false;
    await setQueue(_recentQueue, autoPlay: true);
  }

  Future<void> stop() async {
    await _clearTranslationPlayback(disposeRecent: false);
    _queue.clear();
    _currentIndex = -1;
    await _returnToIdle();
  }

  Future<void> _returnToIdle() async {
    if (_disposed) return;
    if (!_idleEnabled) {
      _state = VideoQueuePlaybackState.idle;
      _notify();
      return;
    }

    await _clearTranslationPlayback(disposeRecent: false);
    _queue.clear();
    _currentIndex = -1;
    _error = null;
    _isIdleMode = true;

    try {
      await _ensureIdleController();
      await _idleController!.setLooping(true);
      await _idleController!.play();
      _state = VideoQueuePlaybackState.playing;
      debugPrint('Current video: $idleVideoAsset');
    } catch (error) {
      _error = error;
      _state = VideoQueuePlaybackState.error;
      debugPrint('VideoQueueManager failed to start idle video: $error');
    }

    _notify();
  }

  Future<void> _ensureIdleController() async {
    if (_idleController != null && _idleController!.value.isInitialized) {
      await _idleController!.seekTo(Duration.zero);
      return;
    }

    _idleController?.dispose();
    _idleController = _createController(idleVideoAsset);
    await _idleController!.initialize();
    await _idleController!.setVolume(0);
    await _idleController!.setLooping(true);
  }

  Future<void> _pauseIdle() async {
    if (_idleController?.value.isPlaying ?? false) {
      await _idleController?.pause();
    }
  }

  Future<void> _loadCurrentController() async {
    if (_currentIndex < 0 || _currentIndex >= _queue.length) return;

    final source = _queue[_currentIndex];
    debugPrint('Current video: $source');
    final previousController = _translationController;
    previousController?.removeListener(_handlePlaybackTick);

    if (_nextController != null && _nextSource == source) {
      _translationController = _nextController;
      _nextController = null;
      _nextSource = null;
    } else {
      _translationController = _createController(source);
      await _translationController!.initialize();
    }

    await _translationController!.setVolume(0);
    _translationController!.addListener(_handlePlaybackTick);
    if (previousController != null) {
      unawaited(
        Future<void>.delayed(const Duration(milliseconds: 180))
            .then((_) => previousController.dispose()),
      );
    }
  }

  Future<void> _preloadNextController() async {
    await _disposeNextController();

    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _queue.length) return;

    _nextSource = _queue[nextIndex];
    _nextController = _createController(_nextSource!);
    try {
      await _nextController!.initialize();
      await _nextController!.setVolume(0);
    } catch (_) {
      await _disposeNextController();
    }
  }

  void _handlePlaybackTick() {
    final controller = _translationController;
    if (_isIdleMode ||
        _isAdvancing ||
        _state == VideoQueuePlaybackState.completed ||
        _state == VideoQueuePlaybackState.stopped ||
        _state == VideoQueuePlaybackState.error ||
        _state == VideoQueuePlaybackState.paused) {
      return;
    }
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isPlaying) return;
    if (controller.value.position < controller.value.duration) return;
    unawaited(_playNext());
  }

  Future<void> _playNext() async {
    if (_isAdvancing) return;
    _isAdvancing = true;
    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _queue.length) {
      _state = VideoQueuePlaybackState.completed;
      _notify();
      _isAdvancing = false;
      await _returnToIdle();
      return;
    }

    _currentIndex = nextIndex;

    try {
      await _loadCurrentController();
      await _preloadNextController();
      await _translationController?.play();
      if (_currentIndex >= 0 && _currentIndex < _queue.length) {
        debugPrint('Current video: ${_queue[_currentIndex]}');
      }
      _state = VideoQueuePlaybackState.playing;
      _notify();
    } catch (error) {
      _error = error;
      _state = VideoQueuePlaybackState.error;
      _notify();
    } finally {
      _isAdvancing = false;
    }
  }

  VideoPlayerController _createController(String source) {
    return VideoPlayerController.asset(source);
  }

  Future<void> _clearTranslationPlayback({required bool disposeRecent}) async {
    final controller = _translationController;
    _translationController = null;
    controller?.removeListener(_handlePlaybackTick);
    _notify();
    await controller?.dispose();
    await _disposeNextController();
    if (disposeRecent) _recentQueue.clear();
  }

  Future<void> _disposeNextController() async {
    await _nextController?.dispose();
    _nextController = null;
    _nextSource = null;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _translationController?.removeListener(_handlePlaybackTick);
    unawaited(_translationController?.dispose());
    unawaited(_nextController?.dispose());
    unawaited(_idleController?.dispose());
    super.dispose();
  }
}
