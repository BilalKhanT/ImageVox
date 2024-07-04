import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render.dart';
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

  Future<void> convertPdfToImageAndRecognizeText(String pdfPath) async {
    emit(PdfConversion());
    final doc = await PdfDocument.openFile(pdfPath);
    final pageCount = doc.pageCount;

    for (int i = 1; i <= pageCount; i++) {
      final page = await doc.getPage(i);
      final pageImage = await page.render(
        width: page.width.toInt(),
        height: page.height.toInt(),
      );

      final imgFile = await saveImageFile(pageImage, i);
      final inputImage = InputImage.fromFilePath(imgFile.path);
      await convertImageToText(inputImage);

      pageImage.dispose();
    }
    await doc.dispose();
  }

  Future<File> saveImageFile(PdfPageImage pageImage, int pageNumber) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/page_$pageNumber.png';
    final imgFile = File(imagePath);

    final Uint8List imgBytes =
        await pageImage.createImageIfNotAvailable().then((image) async {
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    });

    await imgFile.writeAsBytes(imgBytes);
    return imgFile;
  }
}
