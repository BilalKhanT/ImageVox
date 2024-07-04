import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/routes/route_names.dart';
import '../../config/utils/app_colors.dart';
import '../../logic/onboarding/onboarding_cubit.dart';
import '../../logic/onboarding/onboarding_state.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
        if (state is OnBoardingLoaded) {
          PageController controller =
              context.read<OnBoardingCubit>().pageController;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: context.read<OnBoardingCubit>().contents.length,
                    onPageChanged: (int index) {
                      context.read<OnBoardingCubit>().setIndex(index);
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              context.read<OnBoardingCubit>().contents[i].image,
                              height: screenHeight * 0.35),
                          Text(
                            context.read<OnBoardingCubit>().contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Text(
                            context
                                .read<OnBoardingCubit>()
                                .contents[i]
                                .description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    context.read<OnBoardingCubit>().contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (context.read<OnBoardingCubit>().currentIndex ==
                        context.read<OnBoardingCubit>().contents.length - 1) {
                      context.go(RouteNames.homeRoute);
                    }
                    context.read<OnBoardingCubit>().pageController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80.0, vertical: 40.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 15,
                            color: AppColors.textColor.withOpacity(0.66),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.read<OnBoardingCubit>().currentIndex ==
                                        context
                                                .read<OnBoardingCubit>()
                                                .contents
                                                .length -
                                            1
                                    ? 'Get Started'
                                    : 'Next',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: screenWidth * 0.045,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              const Icon(
                                Icons.navigate_next_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: context.read<OnBoardingCubit>().currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.read<OnBoardingCubit>().currentIndex == index
            ? Colors.black
            : Colors.grey,
      ),
    );
  }
}
