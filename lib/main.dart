import 'package:flutter/material.dart';
import 'package:imago_vox/presentation/home/home_view.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ImagoVox',
      home: HomeView(),
    );
  }
}

