import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/routes/route_names.dart';
import 'package:imago_vox/config/utils/app_colors.dart';
import 'package:imago_vox/logic/camera/camera_cubit.dart';
import 'package:imago_vox/presentation/widgets/cstm_btn.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Lottie.asset(
                  "assets/lotties/scan.json",
                  repeat: true,
                ),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'MontserratMedium',
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomButton(
                  onTap: () {
                    context.read<CameraCubit>().initializeCamera(context);
                    context.go(RouteNames.imgCaptureRoute);
                  },
                  text: 'Capture Image',
                  btnColor: AppColors.btnColor,
                  width: width),
              SizedBox(
                height: height * 0.03,
              ),
              CustomButton(
                  onTap: () {},
                  text: 'Upload Image',
                  btnColor: AppColors.btnColor,
                  width: width),
            ],
          ),
        ),
      ),
    );
  }
}
