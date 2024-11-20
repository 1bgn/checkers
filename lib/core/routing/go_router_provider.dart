
import 'package:checker/core/routing/route_name.dart';
import 'package:checker/feature/create_new_game/presentation/ui/create_new_game_screen.dart';
import 'package:checker/feature/select_new_game/presentation/ui/select_new_game_screen.dart';
import 'package:checker/feature/main_screen/presentation/ui/main_screen.dart';
import 'package:checker/feature/server_list_screeen/domain/model/server_game_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../feature/game_screen/presentation/ui/game_field_screen.dart';
import '../../feature/game_screen/presentation/ui/game_screen.dart';
import '../../feature/server_list_screeen/presentation/game_list_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');
final GlobalKey<StatefulNavigationShellState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');
@LazySingleton()
class GoRouterProvider{
   GoRouter? _router;
  GoRouter goRouter(){
    _router??= GoRouter(navigatorKey: _rootNavigatorKey,initialLocation: "/",routes: [
      GoRoute(path: "/game-route",name: gameRoute,pageBuilder: (context,state){
        return NoTransitionPage(child: GameScreen());
      }),GoRoute(path: "/create-game-route",name: createGameRoute,pageBuilder: (context,state){
        return NoTransitionPage(child: CreateNewGameScreen());
      }),
      StatefulShellRoute.indexedStack(branches: [
        StatefulShellBranch(routes: [  GoRoute(path: "/",name: selectGameRoute,pageBuilder: (context,state){
          return NoTransitionPage(child:SelectNewGameScreen(key: UniqueKey(),));
        }),]),
        StatefulShellBranch(routes: [  GoRoute(path: "/open-game-list-route",name: openGameRoute,pageBuilder: (context,state){
          return NoTransitionPage(child:GameListScreen(isPrivate: false,key: UniqueKey(),));
        }),]),
        StatefulShellBranch(routes: [  GoRoute(path: "/private-game-list-route",name: privateGameRoute,pageBuilder: (context,state){
          return NoTransitionPage(child: GameListScreen(isPrivate: true,key: UniqueKey(),));
        }),]),
      ], builder: (context,state,child){
        return  MainScreen(child: child);
      }),
      // ShellRoute(routes: [
      //
      //   GoRoute(path: "/private-game-list-route",name: privateGameRoute,pageBuilder: (context,state){
      //     return NoTransitionPage(child: GameListScreen(isPrivate: true,));
      //   }),
      //   GoRoute(path: "/open-game-list-route",name: openGameRoute,pageBuilder: (context,state){
      //     return NoTransitionPage(child: GameListScreen(isPrivate: false,));
      //   }),
      // ],builder: (context,state,child){
      //   return MainScreen(key:state.pageKey,child: child,);
      // })
    ]);
    return _router!;
  }
}