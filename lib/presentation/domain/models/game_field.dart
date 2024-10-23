import 'package:checker/presentation/domain/models/attck_direction.dart';
import 'package:checker/presentation/domain/models/game_cell.dart';
import 'package:flutter/material.dart';

import 'checker.dart';
import 'package:mobx/mobx.dart';

class GameField with Store {
  final List<GameCell> cells;

  final ObservableList<Checker> whitePositions;
  final ObservableList<Checker> deadWhitePositions;
  final ObservableList<Checker> blackPositions;
  final ObservableList<Checker> deadBlackPositions;
  final ObservableList<GameCell> lightedPositions;
  final ObservableList<GameCell> attackLightedPositions;
  @observable
  Color currentSide = Colors.white;

  bool isLightedCell(GameCell cell) {
    return lightedPositions.contains(cell);
  }

  bool isAttackLightedCell(GameCell cell) {
    return attackLightedPositions.contains(cell);
  }

  List<GameCell> getFreeCells(Checker checker) {
    List<GameCell> freeCells = [];
    final pos = checker.position;

    if (checker.color == Colors.black) {
      if(checker.isQueen){
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 8));
      }
      else{
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      }


      freeCells = freeCells
          .where((element) =>
              !blackPositions.map((y) => y.position).contains(element) &&
              !whitePositions.map((y) => y.position).contains(element))
          .toList();
    } else if (checker.color == Colors.white) {
      if(checker.isQueen){
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 8));
      }
      else{
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 1);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 1));
      }

      freeCells = freeCells
          .where((element) =>
              !whitePositions.map((y) => y.position).contains(element) &&
              !blackPositions.map((y) => y.position).contains(element))
          .toList();
    }
    print(freeCells);
    // cells.forEach((element) {element.})
    return freeCells;
  }

  List<GameCell> takeDiagCells(
      {required GameCell startPoint, required Diag diag, int length = 8}) {
    List<GameCell> freeCells = [];
    switch (diag) {
      case Diag.topLeft:
        freeCells.addAll(List.generate(
            length+1,
            (index) => GameCell(
                row: startPoint.row-index,
                column: startPoint.column-index,
                cellColor: CellColor.black)));
      case Diag.topRight:
        freeCells.addAll(List.generate(
            length+1,
                (index) => GameCell(
                row: startPoint.row-index,
                column: startPoint.column+index,
                cellColor: CellColor.black)));
      case Diag.bottomLeft:
        freeCells.addAll(List.generate(
            length+1,
                (index) => GameCell(
                row: startPoint.row+index,
                column: startPoint.column-index,
                cellColor: CellColor.black)));
      case Diag.bottomRight:
        freeCells.addAll(List.generate(
            length+1,
                (index) => GameCell(
                row: startPoint.row+index,
                column: startPoint.column+index,
                cellColor: CellColor.black)));
    }
    freeCells = freeCells.where((element) => cells.contains(element)).toList();
    freeCells = freeCells.skip(1).toList();
    return freeCells;
  }

  List<GameCell> getFreeCellsAfterAttack(Checker checker) {
    List<GameCell> freeCells = [];
    final pos = checker.position;

    if (checker.color == Colors.black) {
      if(checker.isQueen){
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 8));
      }else{
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 1));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 1));
      }
      var whiteEnemyPositions = whitePositions
          .map((element) => element.position)
          .where((element) => freeCells.contains(element))
          .toList();

      var cellsAfterAttack = whiteEnemyPositions
          .map((e) => AttackDirection(
              row: pos.row - e.row, column: pos.column - e.column))
          .toList()
          .asMap()
          .map((i, e) => MapEntry(
              i,
              GameCell(
                  row: whiteEnemyPositions[i].row - e.row,
                  cellColor: CellColor.black,
                  column: whiteEnemyPositions[i].column - e.column)))
          .values
          .where((element) => !whitePositions
              .map((element) => element.position)
              .contains(element))
          .toList();
      cellsAfterAttack = cellsAfterAttack
          .where((element) =>
              cells.contains(element) &&
              !blackPositions.map((e) => e.position).contains(element))
          .toList();

      print(
          "WHITE ENEMY POSITIONS ${whiteEnemyPositions}\cellsAfterAttack: ${cellsAfterAttack}");
      return cellsAfterAttack;

      // freeCells = freeCells.where((element) => whitePositions.map((y)=>y.position).contains(element)).toList();
    } else if (checker.color == Colors.white) {
      if(checker.isQueen){
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 8));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 8));
      }else{
        freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 1));
        freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 1));
      }
      freeCells = freeCells
          .where((element) =>
              !whitePositions.map((y) => y.position).contains(element))
          .toList();
      var blackEnemyPositions = blackPositions
          .map((element) => element.position)
          .where((element) => freeCells.contains(element))
          .toList();
      var cellsAfterAttack = blackEnemyPositions
          .map((e) => AttackDirection(
              row: pos.row - e.row, column: pos.column - e.column))
          .toList()
          .asMap()
          .map((i, e) => MapEntry(
              i,
              GameCell(
                  row: blackEnemyPositions[i].row - e.row,
                  cellColor: CellColor.black,
                  column: blackEnemyPositions[i].column - e.column)))
          .values
          .where((element) => !blackPositions
              .map((element) => element.position)
              .contains(element))
          .toList();
      cellsAfterAttack = cellsAfterAttack
          .where((element) =>
              cells.contains(element) &&
              !whitePositions.map((e) => e.position).contains(element))
          .toList();
      return cellsAfterAttack;
    }
    // cells.forEach((element) {element.})
    return [];
  }

  Checker? getKilledCheckersAfterAttack(
      Checker checker, GameCell firstPos, GameCell secondPos) {
    List<GameCell> freeCells = [];
    print(firstPos);
    print(secondPos);
    final AttackDirection attackDirection = AttackDirection(
        row: (secondPos.row - firstPos.row).isNegative ? -1 : 1,
        column: (secondPos.column - firstPos.column).isNegative ? -1 : 1);
    final enemyPos = GameCell(
        row: firstPos.row + attackDirection.row,
        column: firstPos.column + attackDirection.column,
        cellColor: CellColor.black);
    if (checker.color == Colors.white) {
      final enemy =
          blackPositions.where((element) => element.position == enemyPos);
      if (enemy.isNotEmpty) {
        return enemy.first;
      }
    } else if (checker.color == Colors.black) {
      final enemy =
          whitePositions.where((element) => element.position == enemyPos);
      if (enemy.isNotEmpty) {
        return enemy.first;
      }
    }
    return null;
  }

  void killChecker(Checker? checker) {
    if (checker?.color == Colors.white) {
      whitePositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker!.position.row);
      deadWhitePositions.add(checker!);
    }
    if (checker?.color == Colors.black) {
      blackPositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker!.position.row);
      deadBlackPositions.add(checker!);
    }
  }

  bool hasOtherKiller(Checker? checker) {
    if (checker?.color == Colors.white) {
      final whitePositions = [...this.whitePositions];
      whitePositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker.position.row);
      return whitePositions
          .any((element) => getFreeCellsAfterAttack(element).isNotEmpty);
    } else if (checker?.color == Colors.black) {
      final blackPositions = [...this.blackPositions];
      blackPositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker!.position.row);
      return blackPositions
          .any((element) => getFreeCellsAfterAttack(element).isNotEmpty);
    }
    return false;
  }

  GameField(
      {required this.cells,
      required this.whitePositions,
      required this.deadBlackPositions,
      required this.deadWhitePositions,
      required this.blackPositions,
      required this.attackLightedPositions,
      required this.lightedPositions});

  @override
  String toString() {
    return 'GameField{cells: $cells}';
  }
}

enum Diag { topLeft, topRight, bottomLeft, bottomRight }
