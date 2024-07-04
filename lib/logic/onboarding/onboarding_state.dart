import 'package:equatable/equatable.dart';

abstract class OnBoardingState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingLoaded extends OnBoardingState {
  final int index;
  OnBoardingLoaded({
    required this.index,
  });
}

class OnBoardingFailure extends OnBoardingState {}