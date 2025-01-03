import 'dart:async';

import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import 'package:checker/feature/game_screen/presentation/controller/online_game_screen_controller.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/black_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/white_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/emoji_row/emoji_row.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/emoji_scene/emoji_scene.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/text_row.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/online_game_screen_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/user_feature/domain/model/user.dart';
import '../../domain/models/game_cell.dart';
import 'components/check_stack/check_stack.dart';
import 'components/current_stage/current_stage.dart';

class OnlineGameFieldScreen extends StatefulWidget {
  const OnlineGameFieldScreen(
      {super.key, required this.gameSession, required this.gameConnection});

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

    controller.init(widget.gameSession, widget.gameConnection).then((v) async {
      await controller.listenGameSession(
          ConnectToGame(nickname: controller.state.currentUser!.nickname),
          controller.state.reciever!);
      // controller.state.sender?.add(WebsocketGameSessionEventSession(eventType: SenderWebsocketEventType.UpdateSessionState,gameSession: controller.state.gameSession));
      controller.sessionJoin();

      onlineSubscription ??= controller.state.reciever?.stream.listen((d) {
        switch (d.websocketEventType) {
          case ReceiveWebsocketEventType.SessionEvent:
            final obj = d as WebsocketGameSessionEvent;

            controller.updateGameSession(obj.gameSession);

            if (d.gameSession.gameSessionItem.winner != null) {
              context.push("/win-game-route",
                  extra: {"gameSession": d.gameSession});
            }

            break;
          // if(obj.gameSession.gameSessionItem.winner)
          case ReceiveWebsocketEventType.FinishGame:
            context.go("/");
            break;
          case ReceiveWebsocketEventType.ResetGameField:
            final obj = d as WebsocketGameSessionEvent;
            controller.updateGameSession(obj.gameSession);
            context.pop();
            break;
          case ReceiveWebsocketEventType.EmojiEvent:
            final obj = d as EmojiWebsocketEvent;
            controller.setEmoji(obj.emoji);
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

  void onGameOver(Color winner) {
    timer?.cancel();
  }

  User? opponent(OnlineGameScreenState state) {
    if (state.currentUser?.id ==
        state.gameSession.gameSessionItem.whiteGamePlayer?.id) {
      return state.gameSession.gameSessionItem.blackGamePlayer;
    }

    return state.gameSession.gameSessionItem.whiteGamePlayer;
  }

  int rotations(OnlineGameScreenState state) {
    if (kDebugMode) {
      return 0;
    }
    return state.gameSession.gameSessionItem.whiteGamePlayer ==
            state.currentUser
        ? 90
        : 0;
  }

  // bool iCanTap(OnlineGameScreenState state){
  //   return state.gameField.currentSide==Colors.white || kDebugMode;
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineGameScreenController, OnlineGameScreenState>(
      builder: (context, state) {
        final controller = context.read<OnlineGameScreenController>();
        final oppoentuser = opponent(state);
        return state.isUploaded
            ? Stack(
              children: [
                ScrollConfiguration(
                  behavior:  ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        oppoentuser != null
                            ? Text(
                                "${oppoentuser.nickname}",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              )
                            : Text(
                                "",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Счет:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CheckStack(
                                  svgIcon:
                                      "assets/images/white_cat_checker.svg",
                                  count: state
                                      .gameField.deadWhitePositions.length),
                              SizedBox(
                                height: 12,
                              ),
                              CheckStack(
                                  svgIcon:
                                      "assets/images/black_cat_checker.svg",
                                  count:
                                      state.gameField.deadBlackPositions.length)
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: LayoutBuilder(builder: (context, constraints) {
                            // final screenSize = MediaQuery.of(context).size;
                            var width =
                                constraints.maxWidth < constraints.maxHeight
                                    ? constraints.maxWidth
                                    : constraints.maxHeight;
                            if (width > MediaQuery.of(context).size.height) {
                              // width = MediaQuery.of(context).size.height-(Scaffold.of(context).appBarMaxHeight??48);
                              width = MediaQuery.of(context).size.height -
                                  (Scaffold.of(context).appBarMaxHeight ?? 48);
                            }
                            final cellWidth = width / 8;
                            return RotatedBox(
                              quarterTurns: rotations(state),
                              child: Center(
                                child: Container(

                                  width: width,
                                  height: width,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(
                                            5,
                                            5,
                                          ),
                                          color: Colors.grey)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.brown),
                                  ),
                                  child: Stack(
                                    children: [
                                      ...state.gameField.cells
                                          .asMap()
                                          .map((i, e) {
                                        final coords = controller.getPosition(
                                            e, cellWidth);
                                        return MapEntry(
                                            i,
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: coords.x - cellWidth,
                                                  top: coords.y - cellWidth),
                                              width: cellWidth,
                                              height: cellWidth,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: i == 0
                                                        ? Radius.circular(12)
                                                        : Radius.zero,
                                                    topRight: i == 7
                                                        ? Radius.circular(12)
                                                        : Radius.zero,
                                                    bottomLeft: i == 56
                                                        ? Radius.circular(12)
                                                        : Radius.zero,
                                                    bottomRight: i == 63
                                                        ? Radius.circular(12)
                                                        : Radius.zero),
                                                color: e.cellColor ==
                                                        CellColor.black
                                                    ? Colors.brown
                                                    : Colors.brown.shade100,
                                              ),
                                              child: _LightMarker(
                                                cell: e,
                                                isLight:
                                                    controller.isLightedCell(e),
                                                isAttackLight: controller
                                                    .isAttackLightedCell(e),
                                                onTap: () {
                                                  if (state.currentUser ==
                                                          state
                                                              .gameSession
                                                              .gameSessionItem
                                                              .blackGamePlayer ||
                                                      kDebugMode) {
                                                    final selectedChecker =
                                                        controller
                                                            .getSelectedChecker();
                                                    if (selectedChecker
                                                            ?.color ==
                                                        Colors.black) {
                                                      controller
                                                          .nextSelectedBlackCheckerPosition(
                                                              e);
                                                    }
                                                  }
                                                  if ((state.currentUser ==
                                                          state
                                                              .gameSession
                                                              .gameSessionItem
                                                              .whiteGamePlayer ||
                                                      kDebugMode)) {
                                                    final selectedChecker =
                                                        controller
                                                            .getSelectedChecker();
                                                    if (selectedChecker
                                                            ?.color ==
                                                        Colors.white) {
                                                      controller
                                                          .nextSelectedWhiteCheckerPosition(
                                                              e);
                                                      // controller.state.sender?.add(WebsocketGameSessionEventSession(eventType: SenderWebsocketEventType.UpdateSessionState,gameSession:state.gameSession.copyWith(gameField: res,)));
                                                    }
                                                  }

                                                  controller.upgradeGameField();
                                                  controller.hideLastStep();
                                                  setState(() {});
                                                },
                                              ),
                                            ));
                                      }).values,
                                      ...controller.blackPositions()
                                          .asMap()
                                          .map((i, e) {
                                        final coords = controller.getPosition(
                                            e.position, cellWidth);
                                        return MapEntry(
                                            i,
                                            GestureDetector(
                                              onTap: () {
                                                // mobxMainScreenController.updateBlackChecker(i, e.copy(isSelected: !e.isSelected));
                                                if (state.currentUser ==
                                                        state
                                                            .gameSession
                                                            .gameSessionItem
                                                            .blackGamePlayer ||
                                                    kDebugMode) {
                                                  controller
                                                      .selectBlackChecker(i);
                                                  controller.upgradeGameField();
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: coords.x - cellWidth,
                                                    top: coords.y - cellWidth),
                                                width: cellWidth,
                                                height: cellWidth,
                                                child: RotatedBox(
                                                    quarterTurns:
                                                        rotations(state),
                                                    child: BlackChecker(
                                                      isQueen: e.isQueen,
                                                      isSelected: e.isSelected,
                                                    )),
                                              ),
                                            ));
                                      }).values,
                                      ...controller.whitePositions()
                                          .asMap()
                                          .map((i, e) {
                                        final coords = controller.getPosition(
                                            e.position, cellWidth);
                                        return MapEntry(
                                            i,
                                            GestureDetector(
                                              onTap: () {
                                                if (state.currentUser ==
                                                        state
                                                            .gameSession
                                                            .gameSessionItem
                                                            .whiteGamePlayer ||
                                                    kDebugMode) {
                                                  controller
                                                      .selectWhiteChecker(i);
                                                  controller.upgradeGameField();
                                                  controller.hideLastStep();
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: coords.x - cellWidth,
                                                    top: coords.y - cellWidth),
                                                width: cellWidth,
                                                height: cellWidth,
                                                child: RotatedBox(
                                                    quarterTurns:
                                                        rotations(state),
                                                    child: WhiteChecker(
                                                      isQueen: e.isQueen,
                                                      isSelected: e.isSelected,
                                                    )),
                                              ),
                                            ));
                                      }).values
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CurrentStage(
                                  color: state.gameField.currentSide,
                                  winner: state.winner),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        EmojiRow(
                          selectEmoji: (e) {
                            controller.sendEmoji(e);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [

                              state.lastStepGameField==null?Expanded(
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    iconColor: WidgetStatePropertyAll(Colors.white),
                                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                                      backgroundColor:controller.isYourStep()&&state.history.isNotEmpty
                                          ? WidgetStatePropertyAll(Colors.green)
                                          : WidgetStatePropertyAll(Colors.grey)),
                                  onPressed: () {
                                    if(controller.isYourStep()&&state.history.isNotEmpty){
                                      controller.showLastStep();
                                    }
                                  },
                                  icon: Icon(Icons.replay),
                                  label: Text("Last replay"),
                                ),
                              ):Expanded(
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      iconColor: WidgetStatePropertyAll(Colors.white),
                                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                                      backgroundColor:controller.isYourStep()&&state.history.isNotEmpty
                                          ? WidgetStatePropertyAll(Colors.green)
                                          : WidgetStatePropertyAll(Colors.grey)),
                                  onPressed: () {
                                    if(controller.isYourStep()&&state.history.isNotEmpty){
                                      controller.hideLastStep();
                                    }
                                  },
                                  icon: Icon(Icons.reply_outlined),
                                  label: Text("Current step"),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              // FilledButton(onPressed: (){}, child: Text("Дзынь!!!",),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.yellow))),
                              // SizedBox(
                              //   width: 16,
                              // ),
                             state.gameSession.gameSessionItem.whiteGamePlayer!=null && state.gameSession.gameSessionItem.blackGamePlayer!=null? FilledButton(onPressed: (){
                                controller.lose();
                              }, child: Text("Сдаться"),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),):FilledButton(onPressed: (){
                               controller.lose();
                             }, child: Text("Сдаться"),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),),

                              // Expanded(
                              //   child: TextRow(selectText: (e) {
                              //     controller.sendEmoji(e);
                              //   }),
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Expanded(child: TextRow(selectText: (t){
                            controller.sendEmoji(t);
                          }))
                        ],),
                        SizedBox(
                          height: 16,
                        ),
                        // Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Session id: "),SizedBox(width: 6,),Text(widget.gameSession.gameSessionItem.id.substring(0,8))],)
                      ],
                    ),
                  ),
                ),
                state.currentEmoji != null
                    ? Align(
                        child: EmojiScene(
                          content: state.currentEmoji!.emoji,
                          callback: () {
                            controller.setEmoji(null);
                          },
                        ),
                        alignment: state.currentUser!.accessToken ==
                                state.currentEmoji!.accessTokenFrom
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                      )
                    : SizedBox()
              ],
            )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  String currentTime(OnlineGameScreenState state) {
    final minutes = Duration(seconds: state.timeCounter).inMinutes;
    final seconds = Duration(seconds: state.timeCounter % 60).inSeconds;
    return "${minutes < 10 ? "0$minutes" : minutes}:${seconds < 10 ? "0$seconds" : seconds}";
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
