import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/di/di_container.dart';
import 'core/routing/go_router_provider.dart';
import 'feature/game_screen/presentation/ui/game_field_screen.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    final route = getIt.get<GoRouterProvider>();

    return MaterialApp.router(
      routerConfig:route.goRouter() ,
    );
  }
}