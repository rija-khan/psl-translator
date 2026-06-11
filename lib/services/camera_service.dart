import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends ChangeNotifier {
  CameraController? _controller;
  bool _isInitializing = false;
  String? _errorMessage;

  CameraController? get controller => _controller;
  bool get isInitializing => _isInitializing;
  bool get isRunning => _controller?.value.isInitialized ?? false;
  String? get errorMessage => _errorMessage;

  Future<void> start() async {
    if (_isInitializing || isRunning) return;
    _isInitializing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final permission = await Permission.camera.request();
      if (!permission.isGranted) {
        _errorMessage = 'cameraPermissionDenied';
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _errorMessage = 'cameraUnavailable';
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await controller.initialize();
      await _controller?.dispose();
      _controller = controller;
    } catch (_) {
      _errorMessage = 'cameraUnavailable';
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    await _controller?.dispose();
    _controller = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
