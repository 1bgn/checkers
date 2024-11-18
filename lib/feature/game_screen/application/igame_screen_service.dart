import 'dart:ui';

import '../../../core/enum/diag.dart';
import '../domain/models/checker.dart';
import '../domain/models/checker_position.dart';
import '../domain/models/game_cell.dart';
import '../presentation/controller/game_screen_controller.dart';

abstract class IGameScreenService{
  Color? isWin(List<Checker>  deadBlackPositions, List<Checker>  deadWhitePositions);
  CheckerPosition getPosition(GameCell checker, double cellWidth);
  GameCell? findTwiceEnemyDiagCells(List<GameCell> positions);
  bool isNearByDiagCells(GameCell gameCell1, GameCell gameCell2);
  List<GameCell> getFreeCells(
      {
   required List<GameCell> cells,
        required  Checker checker,
        required  List<Checker> blackPositions,
        required List<Checker> whitePositions,
  });
  List<GameCell> takeDiagCells(
      {required List<GameCell> cells,required GameCell startPoint, required Diag diag, int length = 8});
  List<GameCell> cellsBeforeSecondPos(
      List<GameCell> diag, GameCell secondPoint);
  Checker? getKilledCheckersAfterAttack(
      {required List<GameCell> cells,required Checker checker, required GameCell firstPos, required GameCell secondPos,   required  List<Checker> blackPositions,
        required List<Checker> whitePositions,});
  Diag defineDiag(GameCell startPoint, GameCell endPoint);
  List<GameCell> getFreeCellsAfterAttack({required Checker checker,required List<GameCell> cells, required  List<Checker> blackPositions,
    required List<Checker> whitePositions,});
  Map<Diag, List<GameCell>> groupByDiag(
      {required GameCell startPoint, required List<GameCell> cells});
  List<GameCell> sortPointsByDistantionPoint(
      {required GameCell gameCell, required List<GameCell> cells});
  double distanceBetweenPoints(GameCell point1, GameCell point2);
  GameCell cellAfterSecondPos(Diag diag, GameCell secondPos);

}