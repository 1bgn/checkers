import 'package:checker/core/routing/dialog_page.dart';
import 'package:checker/core/routing/route_name.dart';
import 'package:checker/feature/create_new_game/presentation/controller/create_new_game_controller.dart';
import 'package:checker/feature/create_new_game/presentation/ui/create_new_game_screen.dart';
import 'package:checker/feature/game_screen/presentation/controller/game_screen_controller.dart';
import 'package:checker/feature/main_screen/presentation/controller/main_screen_controller.dart';
import 'package:checker/feature/main_screen/presentation/ui/main_screen.dart';
import 'package:checker/feature/select_new_game/presentation/ui/select_new_game_screen.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/controller/game_session_controller.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/game_sessions_screen.dart';
import 'package:checker/feature/win_game_dialog/presentation/controller/win_game_dialog_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../feature/game_screen/presentation/controller/online_game_screen_controller.dart';
import '../../feature/game_screen/presentation/ui/game_screen.dart';
import '../../feature/select_new_game/presentation/controller/select_new_game_screen_controller.dart';
import '../../feature/win_game_dialog/presentation/ui/win_game_dialog.dart';
import '../di/di_container.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey(debugLabel: 'root');
final GlobalKey<StatefulNavigationShellState> _shellNavigatorKey =
GlobalKey(debugLabel: 'shell');

@LazySingleton()
class GoRouterProvider {
  GoRouter? _router;

  GoRouter goRouter() {
    _router ??= GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: "/",
        routes: [
          GoRoute(
              path: "/game-route",
              name: gameRoute,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: BlocProvider(
                      create: (context) => GameScreenController(getIt()),
                      child: GameScreen(),
                    ));
              }),
          GoRoute(
              path: "/online-game-route",
              name: onlineGameRoute,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (context) => GameScreenController(getIt())),
                        BlocProvider(
                            create: (context) =>
                                OnlineGameScreenController(getIt()))
                      ],
                      child: GameScreen(
                        gameSession: (state.extra! as dynamic)[0],
                        gameConnection: (state.extra! as dynamic)[1],
                      ),
                    ));
              }),
          GoRoute(
              path: "/win-game-route",
              name: winGameRoute,
              pageBuilder: (context, state) {
                return DialogPage(
                    builder: (context) =>
                        BlocProvider(
                          create: (context) => WinGameDialogController(getIt()),
                          child: WinGameDialog(
                            gameSession:
                            (state.extra! as dynamic)["gameSession"],
                          ),
                        ),
                    barrierDismissible: false
                );
              }),
          GoRoute(
              path: "/create-game-route",
              name: createGameRoute,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: BlocProvider(
                      create: (context) => CreateNewGameController(getIt()),
                      child: CreateNewGameScreen(),
                    ));
              }),
          StatefulShellRoute.indexedStack(
              branches: [
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: "/",
                      name: selectGameRoute,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                            child: BlocProvider(
                              create: (context) => SelectNewGameScreenController(getIt()),
                              child: SelectNewGameScreen(
                                key: UniqueKey(),
                              ),
                            ));
                      }),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: "/open-game-list-route",
                      name: openGameRoute,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                            child: BlocProvider(
                              create: (context) =>
                                  GameSessionController(getIt()),
                              child: GameSessionsScreen(
                                isPrivate: false,
                                key: UniqueKey(),
                              ),
                            ));
                      }),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: "/private-game-list-route",
                      name: privateGameRoute,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                            child: BlocProvider(
                              create: (context) =>
                                  GameSessionController(getIt()),
                              child: GameSessionsScreen(
                                isPrivate: true,
                                key: UniqueKey(),
                              ),
                            ));
                      }),
                ]),
              ],
              builder: (context, state, child) {
                return BlocProvider(
                  create: (context) => MainScreenController(getIt()),
                  child: MainScreen(child: child),
                );
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
