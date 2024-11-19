
import 'package:checker/core/routing/route_name.dart';
import 'package:checker/feature/main_screen/presentation/ui/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../feature/game_screen/presentation/ui/game_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');
@Injectable()
class GoRouterProvider{
  GoRouter goRouter(){
    return GoRouter(navigatorKey: _rootNavigatorKey,initialLocation: "/",routes: [
      ShellRoute(routes: [
        GoRoute(path: "/",name: homeRoute,pageBuilder: (context,state){
          return NoTransitionPage(child: GameScreen(key: state.pageKey,));
        }),

      ],builder: (context,state,child){
        return MainScreen(key:state.pageKey,child: child,);
      })
    ]);
  }
}