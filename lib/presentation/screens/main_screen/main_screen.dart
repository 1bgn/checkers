import 'package:checker/presentation/domain/models/game_cell.dart';
import 'package:checker/presentation/screens/main_screen/controller/mobx_main_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../di/di_container.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MobxMainScreenController mobxMainScreenController = getIt();

  @override
  void initState() {
    mobxMainScreenController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: mobxMainScreenController.inited
              ? Observer(
                builder: (context) {
                  return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(

                                "Текущий ход: ${mobxMainScreenController.gameField.currentSide==Colors.white?"Белые":"Черные"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: 12,
                        ),
                       Expanded(child: LayoutBuilder(builder: (context,constraints){
                         // final screenSize = MediaQuery.of(context).size;
                         final width = constraints.maxWidth < constraints.maxHeight
                             ? constraints.maxWidth
                             : constraints.maxHeight;
                         final cellWidth = width / 8;
                         return  Observer(
                           builder: (context) {
                             return Container(
                             width: width,
                             height: width,
                             decoration: BoxDecoration(color: Colors.grey),
                             child: Stack(
                               children: [
                                 ...mobxMainScreenController.gameField.cells
                                     .map((e) {
                                   final coords = e.getPosition(cellWidth);
                                   return Container(

                                     margin: EdgeInsets.only(
                                         left: coords.x - cellWidth,
                                         top: coords.y - cellWidth),
                                     width: cellWidth,
                                     height: cellWidth,
                                     decoration: BoxDecoration(
                                       color: e.cellColor == CellColor.black
                                           ? Colors.brown
                                           : Colors.grey.shade300,
                                     ),
                                     child: _LightMarker(
                                       cell: e,
                                       isLight: mobxMainScreenController.gameField
                                           .isLightedCell(e),
                                       isAttackLight: mobxMainScreenController
                                           .gameField
                                           .isAttackLightedCell(e),
                                       onTap: () {
                                         final selectedChecker =
                                         mobxMainScreenController
                                             .getSelectedChecker();
                                         if (selectedChecker?.color ==
                                             Colors.black) {
                                           mobxMainScreenController
                                               .nextSelectedBlackCheckerPosition(e);
                                         }
                                         if (selectedChecker?.color ==
                                             Colors.white) {
                                           mobxMainScreenController
                                               .nextSelectedWhiteCheckerPosition(e);
                                         }
                                         setState(() {

                                         });
                                       },
                                     ),
                                   );
                                 }),
                                 ...mobxMainScreenController.gameField.blackPositions
                                     .asMap()
                                     .map((i, e) {
                                   final coords = e.position.getPosition(cellWidth);
                                   return MapEntry(
                                       i,
                                       GestureDetector(
                                         onTap: () {
                                           // mobxMainScreenController.updateBlackChecker(i, e.copy(isSelected: !e.isSelected));
                                           mobxMainScreenController
                                               .selectBlackChecker(i);
                                         },
                                         child: Container(
                                           child: Center(child: SvgPicture.asset(e.isQueen?"assets/images/black_queen.svg":"assets/images/white_checker.svg",)),

                                           margin: EdgeInsets.only(
                                               left: coords.x - cellWidth,
                                               top: coords.y - cellWidth),
                                           width: cellWidth,
                                           height: cellWidth,

                                           decoration: BoxDecoration(
                                             color: Colors.white,
                                             shape: BoxShape.circle,
                                           ),
                                         ),
                                       ));
                                 }).values,
                                 ...mobxMainScreenController.gameField.whitePositions
                                     .asMap()
                                     .map((i, e) {
                                   final coords = e.position.getPosition(cellWidth);
                                   return MapEntry(
                                       i,
                                       GestureDetector(
                                         onTap: () {
                                           mobxMainScreenController
                                               .selectWhiteChecker(i);
                                         },
                                         child: Container(
                                           margin: EdgeInsets.only(
                                               left: coords.x - cellWidth,
                                               top: coords.y - cellWidth),
                                           width: cellWidth,
                                           height: cellWidth,
                                           child: Center(child: SvgPicture.asset(e.isQueen?"assets/images/white_queen.svg":"assets/images/white_checker.svg",)),
                                           decoration: BoxDecoration(
                                             color: Colors.white,
                                             shape: BoxShape.circle,
                                           ),
                                         ),
                                       ));
                                 }).values
                               ],
                             ),
                                                  );
                           }
                         );})),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                }
              )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
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
      required this.onTap, required this.cell});

  @override
  Widget build(BuildContext context) {
    if (isAttackLight) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Center(
            child: Container(
              child: Center(child: Icon(Icons.close,color: Colors.white,),),

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
              child: Center(child: Icon(Icons.close,color: Colors.white,),),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              width: 30,
              height: 30,
            ),
          ));
    }
    return SizedBox(child: Text("${cell.row} ${cell.column}"),);
  }
}
