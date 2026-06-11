import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/phrase_queue_manager.dart';
import '../services/speech_service.dart';
import '../services/video_queue_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/sign_video_player.dart';

class SpeakScreen extends StatefulWidget {
  const SpeakScreen({super.key});

  @override
  State<SpeakScreen> createState() => _SpeakScreenState();
}

class _SpeakScreenState extends State<SpeakScreen> {
  final TextEditingController _inputController = TextEditingController();
  final SpeechService _speechService = SpeechService();
  final PhraseQueueManager _phraseQueueManager = PhraseQueueManager();
  final VideoQueueManager _videoQueueManager = VideoQueueManager();
  bool _recording = false;
  bool _micPressed = false;
  bool _speechStartInProgress = false;
  String _selectedLanguageCode = 'en';

  @override
  void dispose() {
    _speechService.dispose();
    _phraseQueueManager.dispose();
    _videoQueueManager.dispose();
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _startSpeechRecognition(AppLocalizations l10n) async {
    if (_micPressed || _speechStartInProgress) return;
    _micPressed = true;
    _speechStartInProgress = true;
    setState(() {
      _recording = true;
      _inputController.text = '';
    });

    await _videoQueueManager.stop();
    _phraseQueueManager.clear();

    if (!_micPressed) {
      _speechStartInProgress = false;
      if (mounted) setState(() => _recording = false);
      return;
    }

    await _speechService.startListening(
      onTextChanged: (text) {
        if (!mounted) return;
        setState(() {
          _inputController.text = text;
        });
      },
      onFinalText: _translateSpeechToSigns,
    );
    _speechStartInProgress = false;

    if (!_micPressed) {
      await _stopSpeechRecognition();
    }
  }

  Future<void> _stopSpeechRecognition() async {
    _micPressed = false;
    if (_speechStartInProgress) {
      if (mounted) setState(() => _recording = false);
      return;
    }

    final text = await _speechService.stopListening();
    if (!mounted) return;

    setState(() {
      _recording = false;
      if (text.trim().isNotEmpty) {
        _inputController.text = text.trim();
      }
    });

    await _translateSpeechToSigns(text);
  }

  Future<void> _cancelSpeechRecognition() async {
    _micPressed = false;
    await _speechService.cancelListening();
    if (!mounted) return;
    setState(() => _recording = false);
  }

  Future<void> _translateSpeechToSigns(String speechText) async {
    final videoQueue = _phraseQueueManager.buildFromSpeech(speechText);
    if (videoQueue.isEmpty) return;
    debugPrint('Starting playback: $videoQueue');
    await _videoQueueManager.play(videos: videoQueue);
  }

  Future<void> _sendTextInput() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    await _videoQueueManager.stop();
    await _translateSpeechToSigns(text);
  }

  Future<void> _playCurrentPhraseQueue() async {
    if (_phraseQueueManager.hasVideos) {
      await _videoQueueManager.play();
      return;
    }

    await _translateSpeechToSigns(_inputController.text);
  }

  Future<void> _toggleVideoPlayback() async {
    if (_videoQueueManager.isPlaying) {
      await _videoQueueManager.pause();
      return;
    }
    await _playCurrentPhraseQueue();
  }

  String _selectedLanguageLabel(AppLocalizations l10n) {
    return switch (_selectedLanguageCode) {
      'ur' => l10n.languageUrdu,
      'sd' => l10n.languageSindhi,
      'pa' => l10n.languagePunjabi,
      'ps' => l10n.languagePashto,
      _ => l10n.languageEnglish,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        // Top Card (Translator)
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
                  aspectRatio: 1,
                  child: SignVideoPlayer(
                    queueManager: _videoQueueManager,
                    aspectRatio: 1,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.yourTranslator,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.yourTranslatorSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // How to use Card
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
                              l10n.howToUseSpeak,
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
                          l10n.howToUseSpeakBody,
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
        const SizedBox(height: 32),
        // Mic Button
        Center(
          child: GestureDetector(
            onTapDown: (_) => _startSpeechRecognition(l10n),
            onTapUp: (_) => _stopSpeechRecognition(),
            onTapCancel: _cancelSpeechRecognition,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _recording ? 96 : 80,
              height: _recording ? 96 : 80,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: .3),
                    blurRadius: _recording ? 20 : 12,
                    spreadRadius: _recording ? 4 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.mic, color: Colors.white, size: _recording ? 48 : 36),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            l10n.holdToSpeak,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 32),
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
                  // Language Dropdown
                  PopupMenuButton<String>(
                    initialValue: _selectedLanguageCode,
                    onSelected: (code) => setState(() => _selectedLanguageCode = code),
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
              // Text Area
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: TextField(
                  controller: _inputController,
                  minLines: 4,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: _recording ? l10n.recordingPlaceholder : l10n.speechTranscribedHere,
                    hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: const TextStyle(color: AppTheme.textDark, fontSize: 14),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendTextInput(),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _sendTextInput,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.send, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Send',
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
              const SizedBox(height: 20),
              // Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedBuilder(
                  animation: _videoQueueManager,
                  builder: (context, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ControlButton(
                          icon: _videoQueueManager.isPlaying ? Icons.pause : Icons.play_arrow,
                          onPressed: _toggleVideoPlayback,
                        ),
                        _ControlButton(
                          icon: Icons.refresh,
                          onPressed: _videoQueueManager.replay,
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
