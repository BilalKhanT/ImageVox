import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

sealed class ImageToTextState extends Equatable {
  const ImageToTextState();

  @override
  List<Object?> get props => [];
}

class ImageToTextInitial extends ImageToTextState {}

class ImageToTextLoading extends ImageToTextState {}

class ImageToTextLoaded extends ImageToTextState {
  final String text;

  const ImageToTextLoaded(this.text);
}

class ImageToTextError extends ImageToTextState {
  final String errorMsg;

  const ImageToTextError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
