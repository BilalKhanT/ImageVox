import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:imago_vox/logic/camera/camera_state.dart';
import '../../config/utils/app_utils.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  bool isInitialized = false;
  late CameraController cameraController;
  bool isInitializing = false;
  late List<CameraDescription> _cameras;

  Future<void> dispose() async {
    if (isInitialized) {
      cameraController.dispose();
    }
    emit(CameraInitial());
  }

  Future<void> initializeCamera(BuildContext context) async {
    emit(CameraLoading());
    isInitializing = true;
    try {
      _cameras = await availableCameras();
      final rearCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );
      cameraController = CameraController(
        rearCamera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420,
        enableAudio: false,
      );
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.off);
      await cameraController.setFocusMode(FocusMode.auto);
      isInitializing = false;
      isInitialized = true;
      emit(CameraLoaded(cameraController));
    } catch (e) {
      if (context.mounted) {
        AppUtils.showToast(context, 'Camera Error',
            'Failed to open camera, please try again', true);
      }
      emit(CameraFailure('Camera not available'));
    }
  }

  Future<void> captureImage() async {
    XFile imageFile = await cameraController.takePicture();
    InputImage image = InputImage.fromFilePath(imageFile.path);
    emit(CameraCaptured(image));
  }

  Future<void> uploadImage(XFile img) async {
    InputImage image = InputImage.fromFilePath(img.path);
    emit(CameraCaptured(image));
  }
}
