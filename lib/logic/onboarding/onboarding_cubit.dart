import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/onboarding_content_model.dart';
import 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  List<OnBoardingContent> contents = [
    OnBoardingContent(
        title: 'Scan Images & PDFs Fast & Easy',
        image: 'assets/images/scan.png',
        description: 'Turn your photographs of text or pdf files into text with just a few clicks.'),
    OnBoardingContent(
        title: 'Translate to multiple supported languages',
        image: 'assets/images/translate.png',
        description: 'Having difficulties translating words from printed posts or signages? Once you have scanned an image, we can translate it for you.'),
    OnBoardingContent(
        title: 'Listen to Texts with TTS Feature',
        image: 'assets/images/speech.png',
        description: 'Easily convert scanned text into speech. Perfect for listening on the go or aiding with visual impairments.'),
  ];

  void dispose() {
    pageController.dispose();
  }

  void setIndex(int index) {
    currentIndex = index;
    emit(OnBoardingLoading());
    emit(OnBoardingLoaded(index: currentIndex));
  }
}
