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
    final Map<Diag,List<GameCell>> diags = {
      // Diag.topLeft:takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: checker.isQueen?8:1),
      // Diag.topRight:takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: checker.isQueen?8:1),
      // Diag.bottomLeft:takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: checker.isQueen?8:1),
      // Diag.bottomRight:takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: checker.isQueen?8:1),
    };
    List<GameCell> freeCells = [];
    final pos = checker.position;

    if (checker.color == Colors.black) {
      if(checker.isQueen){
        diags.putIfAbsent(Diag.topLeft, () => takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8))
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
  Diag defineDiag(GameCell startPoint,GameCell endPoint){
    if( startPoint.row > endPoint.row && startPoint.column>endPoint.column){
      return Diag.topLeft;
    }else if( startPoint.row > endPoint.row && startPoint.column<endPoint.column){
      return Diag.topRight;
    }else if( startPoint.row <endPoint.row && startPoint.column>endPoint.column){
      return Diag.bottomLeft;
    }else{
      return Diag.bottomRight;

    }
  }
  List<GameCell> cellsAfterSecondPos(  List<GameCell> diag, GameCell secondPos){
    List<GameCell> enemyPoints = [];
    bool needTake = false;
    for (var element in diag) {
      if(needTake) {
        enemyPoints.add(element);
      }
      if(element == secondPos){
        needTake = true;
      }
    }
    return enemyPoints;
  }
  List<GameCell> cellsBeforeSecondPos(  List<GameCell> diag, GameCell secondPoint){
    List<GameCell> enemyPoints = [];
    bool needTake = false;
    for (var element in diag) {

      if(element == secondPoint){
        needTake = true;
      }
      if(!needTake) {
        enemyPoints.add(element);
      }
    }
    return enemyPoints;
  }
  List<GameCell> getFreeCellsAfterAttack(Checker checker) {

    final Map<Diag,List<GameCell>> diags = {
      Diag.topLeft:takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: checker.isQueen?8:1),
      Diag.topRight:takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: checker.isQueen?8:1),
      Diag.bottomLeft:takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: checker.isQueen?8:1),
      Diag.bottomRight:takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: checker.isQueen?8:1),
    };



    if (checker.color == Colors.black) {
      // if(checker.isQueen){
      //   freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 8);
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 8));
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 8));
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 8));
      // }else{
      //   freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: 1));
      //   freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: 1));
      // }
      var whiteEnemyPositions = whitePositions
          .map((element) => element.position)
          .where((element) => diags[Diag.bottomLeft]!.contains(element) ||diags[Diag.bottomRight ]!.contains(element) ||diags[Diag.topLeft ]!.contains(element)  ||diags[Diag.topRight ]!.contains(element))
          .toList();
      var attackDiags = whiteEnemyPositions.map((e) => defineDiag(checker.position  , e)).map((e) => diags[e]).toList();
       List<GameCell> cellsAfterAttack = [];
      for (int i = 0 ;i<whiteEnemyPositions.length;i++) {
        final enemy = whiteEnemyPositions[i];
        final attackDiag = cellsAfterSecondPos(attackDiags[i]!, enemy);
        cellsAfterAttack.addAll(attackDiag);
      }
      cellsAfterAttack

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

      diags.forEach((key,element) {
        final containsWhite = whitePositions.indexWhere((e) => element.contains(e.position));

        if(containsWhite!=-1){
          final cloneDiag= [...element];
          final white = whitePositions[containsWhite];
          final shortedDiag = cellsBeforeSecondPos(cloneDiag, white.position);
          diags[key] = shortedDiag;


        }
      });

      var blackEnemyPositions = blackPositions
          .map((element) => element.position)
          .where((element) => diags[Diag.bottomLeft]!.contains(element) ||diags[Diag.bottomRight ]!.contains(element) ||diags[Diag.topLeft ]!.contains(element)  ||diags[Diag.topRight ]!.contains(element))
          .toList();
      var attackDiags = blackEnemyPositions.map((e) => defineDiag(checker.position  , e)).map((e) => diags[e]).toList();
      // attackDiags.removeWhere((element) => whitePositions.)


      List<GameCell> cellsAfterAttack = [];
      for (int i = 0 ;i<blackEnemyPositions.length;i++) {
        final enemy = blackEnemyPositions[i];
        final attackDiag = cellsAfterSecondPos(attackDiags[i]!, enemy);
        cellsAfterAttack.addAll(attackDiag);
      }
      cellsAfterAttack

          .where((element) => !whitePositions
          .map((element) => element.position)

          .contains(element))
          .toList();
      cellsAfterAttack = cellsAfterAttack
          .where((element) =>
      cells.contains(element) &&
          !blackPositions.map((e) => e.position).contains(element))
          .toList();
      return cellsAfterAttack;
    }
    // cells.forEach((element) {element.})
    return [];
  }

  Checker? getKilledCheckersAfterAttack(
      Checker checker, GameCell firstPos, GameCell secondPos) {


    final Map<Diag,List<GameCell>> diags = {
      Diag.topLeft:takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: checker.isQueen?8:1),
      Diag.topRight:takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: checker.isQueen?8:1),
      Diag.bottomLeft:takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: checker.isQueen?8:1),
      Diag.bottomRight:takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: checker.isQueen?8:1),
    };
    final diag = defineDiag(firstPos, secondPos);
    if(checker.color == Colors.white){
      var blackEnemyPositions = blackPositions
      // .map((element) => element.position)
          .where((element) => diags[diag]!.contains(element.position))
          .toList();
      if(blackEnemyPositions.isNotEmpty){
        return blackEnemyPositions.first;
      }
    }else{
      var blackEnemyPositions = whitePositions
      // .map((element) => element.position)
          .where((element) => diags[diag]!.contains(element.position))
          .toList();
      if(blackEnemyPositions.isNotEmpty){
        return blackEnemyPositions.first;
      }
    }
    // var attackDiags = blackEnemyPositions.map((e) => defineDiag(checker.position  , e)).map((e) => diags[e]).toList();
    // List<GameCell> cellsAfterAttack = [];
    // for (int i = 0 ;i<blackEnemyPositions.length;i++) {
    //   final enemy = blackEnemyPositions[i];
    //   final attackDiag = cellsAfterEnemy(attackDiags[i]!, enemy);
    //   cellsAfterAttack.addAll(attackDiag);
    // }
    // cellsAfterAttack
    //
    //     .where((element) => !whitePositions
    //     .map((element) => element.position)
    //     .contains(element))
    //     .toList();
    // cellsAfterAttack = cellsAfterAttack
    //     .where((element) =>
    // cells.contains(element) &&
    //     !blackPositions.map((e) => e.position).contains(element))
    //     .toList();
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
