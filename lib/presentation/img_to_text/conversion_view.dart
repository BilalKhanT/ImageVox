import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imago_vox/logic/img_to_txt/img_to_txt_cubit.dart';
import 'package:imago_vox/logic/img_to_txt/img_to_txt_state.dart';
import 'package:imago_vox/presentation/widgets/dot_loader.dart';
import '../../config/routes/route_names.dart';
import '../../config/utils/app_colors.dart';
import '../widgets/cstm_btn.dart';

class ConversionView extends StatefulWidget {
  const ConversionView({super.key});

  @override
  ConversionViewState createState() => ConversionViewState();
}

class ConversionViewState extends State<ConversionView>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<int>? _charCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
              await context.read<ImageToTextCubit>().stopSpeech();
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
        body: BlocBuilder<ImageToTextCubit, ImageToTextState>(
          builder: (context, state) {
            if (state is ImageToTextLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const DotLoader(
                      loaderColor: AppColors.btnColor,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Scanning, please wait...',
                      style: TextStyle(
                        fontFamily: 'MontserratMedium',
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ImageToTextLoaded) {
              _controller?.forward(from: 0.0);
              _charCount = StepTween(begin: 0, end: state.text.length).animate(
                CurvedAnimation(parent: _controller!, curve: Curves.easeIn),
              );
              return Column(
                children: [
                  Container(
                    height: height * 0.15,
                    color: AppColors.appColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan Result',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          Padding(
                            padding: EdgeInsets.only(right: height * 0.25),
                            child: CustomButton(
                                onTap: () {
                                  context.read<ImageToTextCubit>().textToSpeech(state.text);

                                },
                                text: 'Speak',
                                btnColor: AppColors.btnColor,
                                width: width,
                                svgPath: 'assets/svgs/scan.svg',
                                color: Colors.black,
                                padding: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 3),
                            blurRadius: 20,
                            color: const Color(0xFFD3D3D3).withOpacity(.99),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: SingleChildScrollView(
                          child: AnimatedBuilder(
                            animation: _charCount!,
                            builder: (BuildContext context, Widget? child) {
                              String visibleText =
                              state.text.substring(0, _charCount!.value);
                              return Text(
                                visibleText,
                                style: TextStyle(
                                  fontFamily: 'MontserratMedium',
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ImageToTextError) {
              return Center(
                child: Text(
                  'Failed to scan, please return to home page',
                  style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1.0,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
