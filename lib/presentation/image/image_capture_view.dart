import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/utils/app_colors.dart';
import 'package:imago_vox/logic/camera/camera_state.dart';
import 'package:imago_vox/logic/img_to_txt/img_to_txt_cubit.dart';
import 'package:imago_vox/presentation/widgets/cstm_btn.dart';
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
          backgroundColor: AppColors.appColor,
          leading: IconButton(
            onPressed: () async {
              await context.read<CameraCubit>().dispose();
              if (context.mounted) {
                context.go(RouteNames.homeRoute);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: BlocBuilder<CameraCubit, CameraState>(
            builder: (context, state) {
              if (state is CameraLoading) {
                return const Center(
                  child: DotLoader(
                    loaderColor: Colors.white,
                  ),
                );
              } else if (state is CameraFailure) {
                context.go(RouteNames.homeRoute);
                return const SizedBox.shrink();
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
                                        color: AppColors.btnColor,
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
              } else if (state is CameraCaptured) {
                return Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: Image.file(
                        File(state.image.filePath.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: width * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            onTap: () {
                              context.read<CameraCubit>().dispose();
                              context.go(RouteNames.homeRoute);
                            },
                            text: 'Delete',
                            btnColor: AppColors.warningColor,
                            width: width,
                            svgPath: 'assets/svgs/delete.svg',
                            color: Colors.white,
                            padding: 20.0,
                          ),
                          SizedBox(
                            width: height * 0.05,
                          ),
                          CustomButton(
                            onTap: () async {
                              context
                                  .read<ImageToTextCubit>()
                                  .convertImageToText(state.image);
                              await context.read<CameraCubit>().dispose();
                              if (context.mounted) {
                                context.go(RouteNames.conversionRoute);
                              }
                            },
                            text: 'Scan  ',
                            btnColor: AppColors.btnColor,
                            width: width,
                            svgPath: 'assets/svgs/scan.svg',
                            color: Colors.black,
                            padding: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
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
