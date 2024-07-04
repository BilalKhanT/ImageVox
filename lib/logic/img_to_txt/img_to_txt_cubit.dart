import 'package:bloc/bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'img_to_txt_state.dart';

class ImageToTextCubit extends Cubit<ImageToTextState> {
  final FlutterTts flutterTts;
  bool isSpeaking = false;

  ImageToTextCubit()
      : flutterTts = FlutterTts(),
        super(ImageToTextInitial()) {
    flutterTts.setStartHandler(() {
      isSpeaking = true;
    });

    flutterTts.setCompletionHandler(() {
      isSpeaking = false;
    });

    flutterTts.setErrorHandler((msg) {
      isSpeaking = false;
    });
  }

  Future<void> convertImageToText(InputImage image) async {
    emit(ImageToTextLoading());
    try {
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText =
      await textRecognizer.processImage(image);
      final String result = processRecognizedText(recognizedText);
      emit(ImageToTextLoaded(result));
    } catch (e) {
      emit(const ImageToTextError(
          'Something went wrong please try again later.'));
    }
  }

  String processRecognizedText(RecognizedText recognizedText) {
    StringBuffer buffer = StringBuffer();

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        buffer.write(line.text);
        buffer.write('\n');
      }
      buffer.write('\n');
    }

    return buffer.toString();
  }

  Future<void> textToSpeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  Future<void> stopSpeech() async {
    if (isSpeaking) {
      await flutterTts.stop();
    }
  }
}
