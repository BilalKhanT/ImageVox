import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

sealed class CameraState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraLoaded extends CameraState {
  final CameraController camera;

  CameraLoaded(this.camera);
}

class CameraCaptured extends CameraState {
  final InputImage image;

  CameraCaptured(this.image);
}

class CameraFailure extends CameraState {
  final String message;

  CameraFailure(this.message);
}
