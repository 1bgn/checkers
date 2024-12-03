
import 'dart:async';


import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import 'package:checker/common/game_session_feature/domain/model/sender_websocket_event_object.dart';
import 'package:checker/feature/game_screen/presentation/controller/online_game_screen_controller.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/black_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/white_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/game_screen_state.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/online_game_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/di_container.dart';
import '../../domain/models/game_cell.dart';
import 'components/check_stack/check_stack.dart';
import 'components/current_stage/current_stage.dart';

class OnlineGameFieldScreen extends StatefulWidget {
  const OnlineGameFieldScreen({super.key, required this.gameSession, required this.gameConnection});
  final GameSession gameSession;
  final GameConnection gameConnection;

  @override
  State<OnlineGameFieldScreen> createState() => _OnlineGameFieldScreenState();
}

class _OnlineGameFieldScreenState extends State<OnlineGameFieldScreen> {
  // final MobxMainScreenController mobxMainScreenController = getIt();
  StreamSubscription? timer;
  StreamSubscription? onlineSubscription;

  @override
  void initState() {
    final controller = context.read<OnlineGameScreenController>();

    controller.init(widget.gameSession,widget.gameConnection).then((v) async {
      if(v.opponentUser!=null){
        timer = Stream.periodic(Duration(seconds: 1)).listen((event) {
          controller.nextTime();
        });
      }
      await controller.listenGameSession(ConnectToGame(nickname: controller.state.currentUser!.nickname), controller.state.reciever!);
      // controller.state.sender?.add(WebsocketGameSessionEventSession(eventType: SenderWebsocketEventType.UpdateSessionState,gameSession: controller.state.gameSession));
      controller.sessionJoin();

      onlineSubscription ??= controller.state.reciever?.stream.listen((d){
        switch(d.websocketEventType){

          case ReceiveWebsocketEventType.SessionEvent:
            final obj = d as WebsocketGameSessionEvent;
            controller.updateGameSession(obj.gameSession);


        }

      });

    });

    // mobxMainScreenController.onGameOver = onGameOver;
    // mobxMainScreenController.init();
    //

    super.initState();
  }

  @override
  void dispose() {

    timer?.cancel();
    onlineSubscription?.cancel();

    super.dispose();
  }
  void onGameOver(Color winner){
    timer?.cancel();
  }
  int rotations(OnlineGameScreenState state){
   return state.gameSession.gameSessionItem.whiteGamePlayer==state.currentUser? 90:0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineGameScreenController, OnlineGameScreenState>(
    builder: (context, state) {
     final controller =  context.read<OnlineGameScreenController>();
      return state.isUploaded
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CurrentStage(color: state.gameField.currentSide, winner:state.winner),
                  ),
                ],
              ),

              if(state.opponentUser==null)
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12,top: 12),
                      child: Text("Ожидаем вашего оппонента..."),
                    ),
                  ],
                ),
              Expanded(
                flex: 2,
                child: LayoutBuilder(builder: (context, constraints) {
                  // final screenSize = MediaQuery.of(context).size;
                  final width =
                  constraints.maxWidth < constraints.maxHeight
                      ? constraints.maxWidth
                      : constraints.maxHeight;
                  final cellWidth = width / 8;
                  return RotatedBox(
                    quarterTurns: rotations(state),
                    child: Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Stack(
                        children: [
                          ...state.gameField.cells
                              .map((e) {
                            final coords = controller.getPosition(e,cellWidth);
                            return Container(
                              margin: EdgeInsets.only(
                                  left: coords.x - cellWidth,
                                  top: coords.y - cellWidth),
                              width: cellWidth,
                              height: cellWidth,
                              decoration: BoxDecoration(
                                color: e.cellColor == CellColor.black
                                    ? Colors.brown
                                    : Colors.brown.shade100,
                              ),
                              child: _LightMarker(
                                cell: e,
                                isLight: controller
                                    .isLightedCell(e),
                                isAttackLight: controller
                                    .isAttackLightedCell(e),
                                onTap: () {
                    
                                  final selectedChecker =
                                  controller
                                      .getSelectedChecker();

                                  if (selectedChecker?.color ==
                                      Colors.black) {
                                      controller
                                        .nextSelectedBlackCheckerPosition(
                                        e);

                                  }
                                  if (selectedChecker?.color ==
                                      Colors.white) {
                                    controller
                                        .nextSelectedWhiteCheckerPosition(
                                        e);
                                   // controller.state.sender?.add(WebsocketGameSessionEventSession(eventType: SenderWebsocketEventType.UpdateSessionState,gameSession:state.gameSession.copyWith(gameField: res,)));
                                  }
                                  controller.upgradeGameField();


                                  setState(() {});
                                },
                              ),
                            );
                          }),
                          ...state
                              .gameField.blackPositions
                              .asMap()
                              .map((i, e) {
                            final coords =
                           controller.getPosition(e.position,cellWidth);
                            return MapEntry(
                                i,
                                GestureDetector(
                                  onTap: () {
                                    // mobxMainScreenController.updateBlackChecker(i, e.copy(isSelected: !e.isSelected));
                                    controller
                                        .selectBlackChecker(i);
                                   controller.upgradeGameField();

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: coords.x - cellWidth,
                                        top: coords.y - cellWidth),
                                    width: cellWidth,
                                    height: cellWidth,
                                    child: RotatedBox(quarterTurns: rotations(state),child: BlackChecker(isQueen: e.isQueen,isSelected: e.isSelected,)),
                    
                                  ),
                                ));
                          }).values,
                          ...state.gameField.whitePositions
                              .asMap()
                              .map((i, e) {
                            final coords =
                            controller.getPosition(e.position,cellWidth);
                            return MapEntry(
                                i,
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .selectWhiteChecker(i);
                                    controller.upgradeGameField();


                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: coords.x - cellWidth,
                                        top: coords.y - cellWidth),
                                    width: cellWidth,
                                    height: cellWidth,
                                    child: RotatedBox(quarterTurns: rotations(state),child: WhiteChecker(isQueen: e.isQueen,isSelected: e.isSelected,)),
                    
                                  ),
                                ));
                          }).values
                        ],
                      ),
                    ),
                  );
                }),
              ),

              Expanded(flex: 1,child: Column(children: [Row(
                children: [
                  Expanded(
                      child: Text(
                        "Продолжительность: ${currentTime(state)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ))
                ],
              ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Счет:",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CheckStack(
                    svgIcon: "assets/images/white_cat_checker.svg",
                    count: state
                        .gameField.deadWhitePositions.length),
                SizedBox(
                  height: 12,
                ),
                CheckStack(
                    svgIcon: "assets/images/black_cat_checker.svg",
                    count: state
                        .gameField.deadBlackPositions.length)],))
            ],
          )
          : Center(
        child: CircularProgressIndicator(),
      );
    },
    );
  }
  String currentTime(OnlineGameScreenState state){

    final minutes = Duration(seconds: state.timeCounter).inMinutes;
    final seconds = Duration(seconds: state.timeCounter%60).inSeconds;
    return "${minutes<10?"0$minutes":minutes}:${seconds<10?"0$seconds":seconds}";
  }
}

class _LightMarker extends StatelessWidget {
  final bool isLight;
  final bool isAttackLight;
  final VoidCallback onTap;
  final GameCell cell;

  const _LightMarker(
      {super.key,
      required this.isLight,
      required this.isAttackLight,
      required this.onTap,
      required this.cell});

  @override
  Widget build(BuildContext context) {
    if (isAttackLight) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Center(
            child: Container(
              child: Center(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              width: 30,
              height: 30,
            ),
          ));
    }
    if (isLight) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Center(
            child: Container(
              child: Center(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              width: 30,
              height: 30,
            ),
          ));
    }
    // return SizedBox(child: Text("${cell.row} ${cell.column}"),);
    return SizedBox();
  }
}
