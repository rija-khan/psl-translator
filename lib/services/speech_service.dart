import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService extends ChangeNotifier {
  SpeechService({SpeechToText? speechToText})
      : _speechToText = speechToText ?? SpeechToText();

  final SpeechToText _speechToText;

  bool _isInitialized = false;
  bool _isListening = false;
  String _recognizedText = '';
  String? _errorMessage;

  bool get isInitialized => _isInitialized;
  bool get isListening => _isListening;
  String get recognizedText => _recognizedText;
  String? get errorMessage => _errorMessage;

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    _isInitialized = await _speechToText.initialize(
      onError: _handleError,
      onStatus: _handleStatus,
      debugLogging: false,
    );

    if (!_isInitialized) {
      _errorMessage = 'Speech recognition is unavailable.';
    } else {
      _errorMessage = null;
    }

    notifyListeners();
    return _isInitialized;
  }

  Future<void> startListening({
    required ValueChanged<String> onTextChanged,
    required ValueChanged<String> onFinalText,
  }) async {
    final ready = await initialize();
    if (!ready || _isListening) return;

    _recognizedText = '';
    _errorMessage = null;
    _isListening = true;
    notifyListeners();

    await _speechToText.listen(
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        partialResults: true,
        cancelOnError: true,
        onDevice: true,
      ),
      onResult: (SpeechRecognitionResult result) {
        _recognizedText = result.recognizedWords;
        debugPrint('Recognized text: $_recognizedText');
        onTextChanged(_recognizedText);
        notifyListeners();

        if (result.finalResult) {
          _isListening = false;
          notifyListeners();
          onFinalText(_recognizedText);
        }
      },
    );
  }

  Future<String> stopListening() async {
    if (!_isListening) return _recognizedText;

    await _speechToText.stop();
    _isListening = false;
    notifyListeners();
    return _recognizedText;
  }

  Future<void> cancelListening() async {
    await _speechToText.cancel();
    _isListening = false;
    notifyListeners();
  }

  void _handleStatus(String status) {
    _isListening = status == 'listening';
    notifyListeners();
  }

  void _handleError(SpeechRecognitionError error) {
    _errorMessage = error.errorMsg;
    _isListening = false;
    notifyListeners();
  }
}
