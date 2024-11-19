import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/di/di_container.dart';
import 'core/routing/go_router_provider.dart';
import 'feature/game_screen/presentation/ui/game_screen.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final route = getIt.get<GoRouterProvider>();

    return MaterialApp.router(
      routerConfig:route.goRouter() ,
    );
  }
}