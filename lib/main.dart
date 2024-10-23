import 'package:checker/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import 'di/di_container.dart';

void main() {
  initDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen(),);
  }
}