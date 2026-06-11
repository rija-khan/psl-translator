import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../l10n/app_localizations.dart';
import '../services/video_queue_manager.dart';

class SignVideoPlayer extends StatefulWidget {
  const SignVideoPlayer({
    this.videoUrl,
    this.videoUrls,
    this.queueManager,
    this.aspectRatio = 9 / 16,
    this.autoPlay = false,
    super.key,
  }) : assert(
          videoUrl == null || videoUrls == null,
          'Provide either videoUrl or videoUrls, not both.',
        );

  final String? videoUrl;
  final List<String>? videoUrls;
  final VideoQueueManager? queueManager;
  final double aspectRatio;
  final bool autoPlay;

  static const demoVideo = VideoQueueManager.idleVideoAsset;

  @override
  State<SignVideoPlayer> createState() => _SignVideoPlayerState();
}

class _SignVideoPlayerState extends State<SignVideoPlayer> {
  late VideoQueueManager _queueManager;
  VideoPlayerController? _videoController;
  bool _ownsQueueManager = false;

  @override
  void initState() {
    super.initState();
    _attachQueueManager();
    unawaited(_loadInitialQueue());
  }

  @override
  void didUpdateWidget(covariant SignVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.queueManager != widget.queueManager) {
      _detachQueueManager();
      _attachQueueManager();
    }

    if (oldWidget.videoUrl != widget.videoUrl ||
        oldWidget.videoUrls != widget.videoUrls ||
        oldWidget.autoPlay != widget.autoPlay) {
      unawaited(_loadInitialQueue());
    }
  }

  void _attachQueueManager() {
    _queueManager = widget.queueManager ??
        VideoQueueManager(idleEnabled: widget.videoUrl == null && widget.videoUrls == null);
    _ownsQueueManager = widget.queueManager == null;
    _queueManager.addListener(_handleQueueChanged);
    _handleQueueChanged();
  }

  void _detachQueueManager() {
    _queueManager.removeListener(_handleQueueChanged);
    if (_ownsQueueManager) {
      _queueManager.dispose();
    }
    _videoController = null;
  }

  Future<void> _loadInitialQueue() async {
    final queue = widget.videoUrls ??
        (widget.videoUrl == null ? null : <String>[widget.videoUrl!]);
    if (queue == null && widget.queueManager != null) {
      return;
    }
    if (queue == null) {
      return;
    }
    await _queueManager.setQueue(queue, autoPlay: widget.autoPlay);
  }

  void _handleQueueChanged() {
    final nextController = _queueManager.currentController;

    if (nextController != _videoController) {
      _videoController = nextController;
    }

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _detachQueueManager();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Container(
              width: constraints.maxWidth,
              color: const Color(0xFF111827),
              child: _content(context),
            ),
          ),
        );
      },
    );
  }

  Widget _content(BuildContext context) {
    if (_queueManager.state == VideoQueuePlaybackState.error) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            l10n.videoError,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final controller = _videoController;
    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.expand();
    }

    return _AvatarVideo(controller: controller);
  }
}

class _AvatarVideo extends StatelessWidget {
  const _AvatarVideo({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.size;
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}
