import 'dart:async';

import 'package:flutter/foundation.dart';

import 'gesture_buffer.dart';

class GestureDetectorService extends ChangeNotifier {
  GestureDetectorService({GestureBuffer? gestureBuffer})
      : _gestureBuffer = gestureBuffer ?? GestureBuffer();

  final GestureBuffer _gestureBuffer;
  final List<Timer> _timers = <Timer>[];
  static const List<String> _demoGestureCycle = [
    'thumbs_up',
    'victory',
    'open_palm',
    'fist',
  ];
  static int _nextDemoGestureIndex = 0;

  bool _isDetecting = false;
  String? _currentGesture;

  bool get isDetecting => _isDetecting;
  String? get currentGesture => _currentGesture;

  void startDemoDetection({required ValueChanged<String> onStableGesture}) {
    stop();
    _isDetecting = true;
    notifyListeners();

    final gesture = _demoGestureCycle[_nextDemoGestureIndex];
    _nextDemoGestureIndex = (_nextDemoGestureIndex + 1) % _demoGestureCycle.length;

    const frameInterval = Duration(milliseconds: 200);
    for (var elapsed = Duration.zero;
        elapsed <= const Duration(milliseconds: 2200);
        elapsed += frameInterval) {
      _timers.add(
        Timer(elapsed, () {
          processFrame(gesture, onStableGesture: onStableGesture);
        }),
      );
    }
  }

  void processFrame(String? gesture, {required ValueChanged<String> onStableGesture}) {
    if (!_isDetecting) return;
    _currentGesture = gesture;
    final stableGesture = _gestureBuffer.addFrame(gesture);
    if (stableGesture != null) onStableGesture(stableGesture);
    notifyListeners();
  }

  void stop() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
    _gestureBuffer.reset();
    _currentGesture = null;
    _isDetecting = false;
    notifyListeners();
  }
}
