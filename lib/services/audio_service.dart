import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioService extends ChangeNotifier {
  AudioService() {
    _processingStateSubscription =
        _player.processingStateStream.listen(_handleProcessingState);
  }

  final AudioPlayer _player = AudioPlayer();
  final List<String> _queue = <String>[];
  final List<String> _recentQueue = <String>[];
  int _currentIndex = -1;
  bool _isAdvancing = false;
  StreamSubscription<ProcessingState>? _processingStateSubscription;

  List<String> get queue => List.unmodifiable(_queue);
  int get currentIndex => _currentIndex;
  bool get hasQueue => _queue.isNotEmpty;
  bool get isPlaying => _player.playing;

  Future<void> setQueue(List<String> audioQueue) => _setQueue(audioQueue);

  Future<void> play({List<String>? audioQueue}) async {
    if (audioQueue != null) {
      await _setQueue(audioQueue);
    } else if (_queue.isEmpty && _recentQueue.isNotEmpty) {
      await replay();
      return;
    }

    if (_queue.isEmpty) return;
    await _player.play();
    notifyListeners();
  }

  Future<void> pause() async {
    await _player.pause();
    notifyListeners();
  }

  Future<void> replay() async {
    if (_recentQueue.isEmpty) return;
    await _setQueue(_recentQueue);
    await play();
  }

  Future<void> stop() async {
    _isAdvancing = true;
    try {
      await _player.stop();
      _queue.clear();
      _currentIndex = -1;
      notifyListeners();
    } finally {
      _isAdvancing = false;
    }
  }

  Future<void> _setQueue(List<String> audioQueue) async {
    final cleanQueue =
        audioQueue.where((audio) => audio.trim().isNotEmpty).toList();

    _isAdvancing = true;
    try {
      await _player.stop();
      _queue
        ..clear()
        ..addAll(cleanQueue);
      _recentQueue
        ..clear()
        ..addAll(cleanQueue);
      _currentIndex = cleanQueue.isEmpty ? -1 : 0;

      if (cleanQueue.isEmpty) {
        notifyListeners();
        return;
      }

      await _player.setAsset(
        cleanQueue.first,
        preload: false,
      );
    } catch (error) {
      debugPrint('AudioService failed to load queue $cleanQueue: $error');
      rethrow;
    } finally {
      _isAdvancing = false;
    }
    notifyListeners();
  }

  void _handleProcessingState(ProcessingState state) {
    if (_isAdvancing || _queue.isEmpty || _currentIndex < 0) return;
    if (state != ProcessingState.completed) return;
    if (_currentIndex >= _queue.length - 1) return;
    unawaited(_playNextInQueue());
  }

  Future<void> _playNextInQueue() async {
    if (_isAdvancing) return;

    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _queue.length) return;

    _isAdvancing = true;
    try {
      _currentIndex = nextIndex;
      await _player.setAsset(
        _queue[_currentIndex],
        preload: true,
      );
      await _player.play();
      notifyListeners();
    } catch (error) {
      debugPrint(
        'AudioService failed to play track $_currentIndex '
        '(${_queue[_currentIndex]}): $error',
      );
    } finally {
      _isAdvancing = false;
    }
  }

  @override
  void dispose() {
    unawaited(_processingStateSubscription?.cancel());
    unawaited(_player.dispose());
    super.dispose();
  }
}
