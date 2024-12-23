import 'dart:async';

import 'package:checker/feature/game_screen/presentation/controller/game_screen_controller.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/black_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/components/checkers/white_checker.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/game_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/game_cell.dart';
import 'components/check_stack/check_stack.dart';
import 'components/current_stage/current_stage.dart';

class GameFieldScreen extends StatefulWidget {
  const GameFieldScreen({super.key});

  @override
  State<GameFieldScreen> createState() => _GameFieldScreenState();
}

class _GameFieldScreenState extends State<GameFieldScreen> {
  // final MobxMainScreenController mobxMainScreenController = getIt();
  StreamSubscription? timer;

  @override
  void initState() {
    final controller = context.read<GameScreenController>();
    controller.init();
    // mobxMainScreenController.onGameOver = onGameOver;
    // mobxMainScreenController.init();
    timer = Stream.periodic(Duration(seconds: 1)).listen((event) {
      controller.nextTime();
    });
    // Stream.periodic(Duration(seconds: 1)).listen((event) {
    //   if(mobxMainScreenController.isWin()!=null){
    //     mobxMainScreenController.gameOver(mobxMainScreenController.isWin()!);
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onGameOver(Color winner) {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameScreenController, GameScreenState>(
      builder: (context, state) {
        final controller = context.read<GameScreenController>();

        return state.isUploaded
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Row(
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
                            count: state.gameField.deadWhitePositions.length),
                        SizedBox(
                          height: 12,
                        ),
                        CheckStack(
                            svgIcon: "assets/images/black_cat_checker.svg",
                            count: state.gameField.deadBlackPositions.length)
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: LayoutBuilder(builder: (context, constraints) {
                            // final screenSize = MediaQuery.of(context).size;
                            final width =
                                constraints.maxWidth < constraints.maxHeight
                                    ? constraints.maxWidth
                                    : constraints.maxHeight;
                            final cellWidth = width / 8;
                            return Container(

                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(spreadRadius: 1,blurRadius: 7,offset: Offset(5,5,),color: Colors.grey)],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.brown),
                              ),
                              width: width,
                              height: width,
                              // decoration: BoxDecoration(color: Colors.white),
                              child: Stack(
                                children: [
                                  ...state.gameField.cells.asMap().map((i, e) {
                                    final coords =
                                        controller.getPosition(e, cellWidth);
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
                                              topRight:  i == 7
                                                  ? Radius.circular(12)
                                                  : Radius.zero,
                                              bottomLeft:  i == 56
                                                  ? Radius.circular(12)
                                                  : Radius.zero,
                                                bottomRight:  i == 63
                                                    ? Radius.circular(12)
                                                    : Radius.zero


                                            ),
                                            color:
                                                e.cellColor == CellColor.black
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
                                              final selectedChecker = controller
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
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ));
                                  }).values,
                                  ...state.gameField.blackPositions
                                      .asMap()
                                      .map((i, e) {
                                    final coords = controller.getPosition(
                                        e.position, cellWidth);
                                    return MapEntry(
                                        i,
                                        GestureDetector(
                                          onTap: () {
                                            // mobxMainScreenController.updateBlackChecker(i, e.copy(isSelected: !e.isSelected));
                                            controller.selectBlackChecker(i);
                                          },
                                          child: Container(
                                            child: BlackChecker(
                                              isQueen: e.isQueen,
                                              isSelected: e.isSelected,
                                            ),
                                            margin: EdgeInsets.only(
                                                left: coords.x - cellWidth,
                                                top: coords.y - cellWidth),
                                            width: cellWidth,
                                            height: cellWidth,
                                          ),
                                        ));
                                  }).values,
                                  ...state.gameField.whitePositions
                                      .asMap()
                                      .map((i, e) {
                                    final coords = controller.getPosition(
                                        e.position, cellWidth);
                                    return MapEntry(
                                        i,
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectWhiteChecker(i);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: coords.x - cellWidth,
                                                top: coords.y - cellWidth),
                                            width: cellWidth,
                                            height: cellWidth,
                                            child: WhiteChecker(
                                              isQueen: e.isQueen,
                                              isSelected: e.isSelected,
                                            ),
                                          ),
                                        ));
                                  }).values
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
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
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  String currentTime(GameScreenState state) {
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
