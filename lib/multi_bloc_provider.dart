import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imago_vox/logic/camera/camera_cubit.dart';
import 'package:imago_vox/logic/img_to_txt/img_to_txt_cubit.dart';
import 'package:imago_vox/logic/onboarding/onboarding_cubit.dart';

class ProvideMultiBloc extends StatelessWidget {
  final Widget child;

  const ProvideMultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CameraCubit(),
      ),
      BlocProvider(
        create: (context) => ImageToTextCubit(),
      ),
      BlocProvider(
        create: (context) => OnBoardingCubit(),
      ),
    ], child: child);
  }
}
