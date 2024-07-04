import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imago_vox/logic/onboarding/onboarding_cubit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'config/routes/router.dart';
import 'data/local/shared_pref.dart';
import 'multi_bloc_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(
    const ProvideMultiBloc(child: MyApp()),
  );
}

Future<void> initializeApp() async {
  await sharedPrefs.init();
  await initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OnBoardingCubit>().setIndex(0);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
