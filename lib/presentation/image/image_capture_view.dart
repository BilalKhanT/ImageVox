import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/utils/app_colors.dart';
import 'package:imago_vox/config/utils/app_utils.dart';
import 'package:imago_vox/logic/camera/camera_state.dart';
import 'package:imago_vox/presentation/widgets/dot_loader.dart';
import '../../config/routes/route_names.dart';
import '../../logic/camera/camera_cubit.dart';

class ImageCaptureView extends StatelessWidget {
  const ImageCaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.appColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              await context.read<CameraCubit>().dispose();
              if (context.mounted) {
                context.go(RouteNames.homeRoute);
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: BlocConsumer<CameraCubit, CameraState>(
            listener: (context, state) {
              if (state is CameraFailure) {
                AppUtils.showToast(context, 'Camera Error',
                    'Failed to open camera, please try again', true);
              }
            },
            builder: (context, state) {
              if (state is CameraLoading) {
                return const Center(
                  child: DotLoader(
                    loaderColor: Colors.white,
                  ),
                );
              } else if (state is CameraLoaded) {
                CameraController camera = state.camera;
                return camera.value.isInitialized == true
                    ? Stack(
                        children: [
                          SizedBox(
                            height: height,
                            width: width,
                            child: CameraPreview(
                              camera,
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            left: width * 0.4,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await context
                                          .read<CameraCubit>()
                                          .captureImage();
                                    },
                                    child: Container(
                                      height: height * 0.08,
                                      width: height * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            height * 0.04),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(1, 3),
                                            blurRadius: 15,
                                            color: AppColors.textColor
                                                .withOpacity(0.66),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.appColor,
                        ),
                      );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
