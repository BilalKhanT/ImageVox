import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/routes/route_names.dart';
import 'package:imago_vox/presentation/image/image_capture_view.dart';
import 'package:imago_vox/presentation/img_to_text/conversion_view.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/onboarding/onboarding_view.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: RouteNames.onBoardingRoute,
      builder: (context, state) => const OnBoardingView(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: RouteNames.homeRoute,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: RouteNames.imgCaptureRoute,
      builder: (context, state) => const ImageCaptureView(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: RouteNames.conversionRoute,
      builder: (context, state) => const ConversionView(),
    ),
  ],
  initialLocation: RouteNames.onBoardingRoute,
);
