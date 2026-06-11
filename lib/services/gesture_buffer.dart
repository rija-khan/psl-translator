class GestureBuffer {
  GestureBuffer({
    this.stabilityDuration = const Duration(seconds: 2),
  });

  final Duration stabilityDuration;

  String? _candidateGesture;
  String? _lockedGesture;
  DateTime? _candidateStartedAt;

  String? addFrame(String? gesture, {DateTime? now}) {
    final timestamp = now ?? DateTime.now();

    if (gesture == null) {
      _candidateGesture = null;
      _candidateStartedAt = null;
      _lockedGesture = null;
      return null;
    }

    if (gesture == _lockedGesture) return null;

    if (gesture != _candidateGesture) {
      _candidateGesture = gesture;
      _candidateStartedAt = timestamp;
      return null;
    }

    final startedAt = _candidateStartedAt;
    if (startedAt == null) {
      _candidateStartedAt = timestamp;
      return null;
    }

    if (timestamp.difference(startedAt) < stabilityDuration) return null;

    _lockedGesture = gesture;
    return gesture;
  }

  void reset() {
    _candidateGesture = null;
    _candidateStartedAt = null;
    _lockedGesture = null;
  }
}
