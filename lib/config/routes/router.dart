import 'package:go_router/go_router.dart';
import 'package:imago_vox/config/routes/route_names.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../presentation/home/home_view.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: RouteNames.homeRoute,
      builder: (context, state) => const HomeView(),
    ),
  ],
  initialLocation: RouteNames.homeRoute,
);
