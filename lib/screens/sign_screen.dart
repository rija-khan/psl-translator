import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/audio_queue_manager.dart';
import '../services/audio_service.dart';
import '../services/camera_service.dart';
import '../services/gesture_detector_service.dart';
import '../services/gesture_queue_manager.dart';
import '../services/phrase_parser.dart';
import '../services/sign_speech_translation_dictionary.dart';
import '../theme/app_theme.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final CameraService _cameraService = CameraService();
  final TextEditingController _textInputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  final GestureDetectorService _gestureDetectorService = GestureDetectorService();
  final GestureQueueManager _gestureQueueManager = GestureQueueManager();
  final AudioQueueManager _audioQueueManager = AudioQueueManager();
  final AudioService _audioService = AudioService();
  final PhraseParser _phraseParser = PhraseParser();
  Locale? _lastLocale;
  String? _selectedLanguageOverride;

  @override
  void initState() {
    super.initState();
    _cameraService.addListener(_onCameraChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    if (_lastLocale != locale) {
      _lastLocale = locale;
      _refreshTranslationResult();
    }
  }

  void _onCameraChanged() => setState(() {});

  @override
  void dispose() {
    _cameraService.removeListener(_onCameraChanged);
    _gestureDetectorService.dispose();
    _gestureQueueManager.dispose();
    _audioQueueManager.dispose();
    _audioService.dispose();
    _cameraService.dispose();
    _textInputController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  String _selectedLanguageCode(BuildContext context) {
    return _selectedLanguageOverride ?? Localizations.localeOf(context).languageCode;
  }

  void _refreshTranslationResult() {
    final languageCode = _selectedLanguageCode(context);
    _resultController.text = SignSpeechTranslationDictionary.formatPhrases(
      _gestureQueueManager.phraseQueue,
      languageCode,
    );
  }

  String _selectedLanguageLabel(AppLocalizations l10n) {
    return switch (_selectedLanguageCode(context)) {
      'ur' => l10n.languageUrdu,
      'sd' => l10n.languageSindhi,
      'pa' => l10n.languagePunjabi,
      'ps' => l10n.languagePashto,
      _ => l10n.languageEnglish,
    };
  }

  Future<void> _setSelectedLanguage(String languageCode) async {
    setState(() {
      _selectedLanguageOverride = languageCode;
      _refreshTranslationResult();
    });
    await _refreshAudioQueueForSelectedLanguage();
  }

  Future<void> _refreshAudioQueueForSelectedLanguage() async {
    if (!_gestureQueueManager.hasPhrases) return;
    final audioQueue = _audioQueueManager.buildAudioQueue(
      phrases: _gestureQueueManager.phraseQueue,
      language: _selectedAudioLanguage(context),
    );
    await _audioService.setQueue(audioQueue);
  }

  Future<void> _startSigning() async {
    await _audioService.stop();
    _gestureQueueManager.clear();
    _audioQueueManager.clear();
    _textInputController.clear();
    _resultController.clear();

    await _cameraService.start();
    _gestureDetectorService.startDemoDetection(
      onStableGesture: (gesture) {
        _gestureQueueManager.addGesture(gesture);
        if (!mounted) return;
        setState(_refreshTranslationResult);
      },
    );
  }

  Future<void> _translateTextInput() async {
    final phrases = _phraseParser.parse(_textInputController.text);
    if (phrases.isEmpty) return;

    _gestureQueueManager.setPhrases(phrases);
    if (!mounted) return;
    setState(_refreshTranslationResult);

    final audioQueue = await _buildSelectedAudioQueue();
    if (audioQueue.isEmpty) return;

    await _audioService.play(audioQueue: audioQueue);
    if (mounted) setState(() {});
  }

  Future<void> _stopAndTranslate() async {
    final language = _selectedAudioLanguage(context);
    _gestureDetectorService.stop();
    await _cameraService.stop();

    final audioQueue = _audioQueueManager.buildAudioQueue(
      phrases: _gestureQueueManager.phraseQueue,
      language: language,
    );
    if (audioQueue.isEmpty) return;

    await _audioService.play(audioQueue: audioQueue);
    if (mounted) setState(() {});
  }

  Future<void> _stopAudioPlayback() async {
    await _audioService.stop();
    _audioQueueManager.clear();
    if (mounted) setState(() {});
  }

  String _selectedAudioLanguage(BuildContext context) {
    return switch (_selectedLanguageCode(context)) {
      'ur' => 'urdu',
      'sd' => 'sindhi',
      'pa' => 'punjabi',
      'ps' => 'pushto',
      _ => 'english',
    };
  }

  Future<List<String>> _buildSelectedAudioQueue() async {
    final audioQueue = _audioQueueManager.buildAudioQueue(
      phrases: _gestureQueueManager.phraseQueue,
      language: _selectedAudioLanguage(context),
    );
    await _audioService.setQueue(audioQueue);
    return audioQueue;
  }

  Future<void> _playSelectedAudioQueue() async {
    final audioQueue = await _buildSelectedAudioQueue();
    if (audioQueue.isEmpty) return;
    await _audioService.play();
  }

  Future<void> _toggleAudioPlayback() async {
    if (_audioService.isPlaying) {
      await _audioService.pause();
      return;
    }
    await _playSelectedAudioQueue();
  }

  Future<void> _replaySelectedAudioQueue() async {
    final audioQueue = await _buildSelectedAudioQueue();
    if (audioQueue.isEmpty) return;
    await _audioService.play();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        // Top Info Card
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info, color: AppTheme.primary, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              l10n.signToAudioTitle,
                              style: const TextStyle(
                                color: AppTheme.textDark,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.signToAudioBody,
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Camera Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 0.9,
                  child: Container(
                    color: const Color(0xFF232B38),
                    child: _preview(context, l10n),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _cameraService.isInitializing || _cameraService.isRunning ? null : _startSigning,
                      icon: const Icon(Icons.play_circle_outline, color: AppTheme.primary, size: 20),
                      label: Text(l10n.startSigning, style: const TextStyle(color: AppTheme.primary, fontSize: 14, fontWeight: FontWeight.w700)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primary, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _cameraService.isRunning
                          ? _stopAndTranslate
                          : _audioService.hasQueue
                              ? _stopAudioPlayback
                              : null,
                      icon: const Icon(Icons.stop_circle_outlined, color: Colors.white, size: 20),
                      label: Text(l10n.stopAndTranslate, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, height: 1.1, fontWeight: FontWeight.w700)),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Translation Result Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.g_translate, color: AppTheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    l10n.translationResult,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    initialValue: _selectedLanguageCode(context),
                    onSelected: _setSelectedLanguage,
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
                      PopupMenuItem(value: 'ur', child: Text(l10n.languageUrdu)),
                      PopupMenuItem(value: 'sd', child: Text(l10n.languageSindhi)),
                      PopupMenuItem(value: 'pa', child: Text(l10n.languagePunjabi)),
                      PopupMenuItem(value: 'ps', child: Text(l10n.languagePashto)),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedLanguageLabel(l10n),
                            style: const TextStyle(fontSize: 13, color: AppTheme.textDark),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppTheme.textDark),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: TextField(
                  controller: _textInputController,
                  decoration: InputDecoration(
                    hintText: l10n.signTranslatedHere,
                    hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: const TextStyle(color: AppTheme.textDark, fontSize: 14),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _translateTextInput(),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _translateTextInput,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.translate, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Translate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: TextField(
                  controller: _resultController,
                  readOnly: true,
                  minLines: 4,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(color: AppTheme.textDark, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              // Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedBuilder(
                  animation: _audioService,
                  builder: (context, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ControlButton(
                          icon: _audioService.isPlaying ? Icons.pause : Icons.play_arrow,
                          onPressed: _toggleAudioPlayback,
                        ),
                        _ControlButton(
                          icon: Icons.refresh,
                          onPressed: _replaySelectedAudioQueue,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Speed segment
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SpeedPill(label: l10n.slow, isSelected: false),
                  const SizedBox(width: 8),
                  _SpeedPill(label: l10n.normal, isSelected: true),
                  const SizedBox(width: 8),
                  _SpeedPill(label: l10n.fast, isSelected: false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _preview(BuildContext context, AppLocalizations l10n) {
    if (_cameraService.isInitializing) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
    }

    final controller = _cameraService.controller;
    
    Widget placeholderOverlay = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CustomPaint(
            painter: _DashedCirclePainter(color: Colors.white.withValues(alpha: .3)),
            child: Center(
              child: Text(
                l10n.positionYourselfHere,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.cameraReadyStart,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );

    if (controller != null && controller.value.isInitialized) {
      final previewSize = controller.value.previewSize;
      final preview = previewSize == null
          ? CameraPreview(controller)
          : FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: previewSize.height,
                height: previewSize.width,
                child: CameraPreview(controller),
              ),
            );
      return Stack(
        fit: StackFit.expand,
        children: [
          preview,
          if (!_cameraService.isRunning)
            Container(color: const Color(0xFF232B38).withValues(alpha: .8)), // Dark overlay
          if (!_cameraService.isRunning)
            placeholderOverlay,
        ],
      );
    }

    final errorMessage = _cameraService.errorMessage;
    final label = switch (errorMessage) {
      'cameraPermissionDenied' => l10n.cameraPermissionDenied,
      'cameraUnavailable' => l10n.cameraUnavailable,
      _ => l10n.cameraReady,
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(radius, radius);
    
    const int dashCount = 60;
    const double sweepAngle = (2 * math.pi) / dashCount;
    
    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          i * sweepAngle,
          sweepAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.textDark, size: 24),
      ),
    );
  }
}

class _SpeedPill extends StatelessWidget {
  const _SpeedPill({required this.label, required this.isSelected});
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primary : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textDark,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}
