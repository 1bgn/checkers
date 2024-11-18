import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:math' as math;

import 'checker.dart';
import 'package:mobx/mobx.dart';

import 'game_cell.dart';

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
    final Map<Diag, List<GameCell>> diags = {
      // Diag.topLeft:takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: checker.isQueen?8:1),
      // Diag.topRight:takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: checker.isQueen?8:1),
      // Diag.bottomLeft:takeDiagCells(startPoint: checker.position, diag: Diag.bottomLeft,length: checker.isQueen?8:1),
      // Diag.bottomRight:takeDiagCells(startPoint: checker.position, diag: Diag.bottomRight,length: checker.isQueen?8:1),
    };
    // List<GameCell> freeCells = [];
    // final pos = checker.position;

    if (checker.color == Colors.black) {
      if (checker.isQueen) {
        diags.putIfAbsent(
            Diag.topLeft,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topLeft, length: 8));
        diags.putIfAbsent(
            Diag.topRight,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topRight, length: 8));
        diags.putIfAbsent(
            Diag.bottomLeft,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 8));
        diags.putIfAbsent(
            Diag.bottomRight,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 8));
      } else {
        diags.putIfAbsent(
            Diag.topLeft,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topLeft, length: 1));
        diags.putIfAbsent(
            Diag.topRight,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topRight, length: 1));

        // freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        // freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      }
      diags.forEach((key, element) {
        final containsBlack =
            blackPositions.indexWhere((e) => element.contains(e.position));

        if (containsBlack != -1) {
          final cloneDiag = [...element];
          final white = blackPositions[containsBlack];
          final shortedDiag = cellsBeforeSecondPos(cloneDiag, white.position);
          diags[key] = shortedDiag;
        }
      });
      var busyPositions = whitePositions
          .map((element) => element.position)
          .where((element) =>
              diags[Diag.topLeft]!.contains(element) ||
              diags[Diag.topRight]!.contains(element) ||
              (diags.containsKey(Diag.bottomRight) &&
                  (diags[Diag.bottomRight]!.contains(element) ||
                      diags[Diag.bottomLeft]!.contains(element))))
          .toList();
      GameCell? nearEnemyPos =findTwiceEnemyDiagCells(busyPositions);

       ;
      return diags.map((d,p){
        var res = p.takeWhile((e)=>e!=nearEnemyPos).toList();

        return MapEntry(d, res);
      }).values
          .expand((element) => element)
          .takeWhile((value) => value != nearEnemyPos)
          .where((element) =>
              !blackPositions.map((y) => y.position).contains(element) &&
              !whitePositions.map((y) => y.position).contains(element))
          .toList();
    } else if (checker.color == Colors.white) {
      if (checker.isQueen) {
        diags.putIfAbsent(
            Diag.topLeft,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topLeft, length: 8));
        diags.putIfAbsent(
            Diag.topRight,
            () => takeDiagCells(
                startPoint: checker.position, diag: Diag.topRight, length: 8));
        diags.putIfAbsent(
            Diag.bottomLeft,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 8));
        diags.putIfAbsent(
            Diag.bottomRight,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 8));
      } else {
        diags.putIfAbsent(
            Diag.bottomLeft,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 1));
        diags.putIfAbsent(
            Diag.bottomRight,
            () => takeDiagCells(
                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 1));

        // freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        // freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      }
      diags.forEach((key, element) {
        final containsBlack =
            whitePositions.indexWhere((e) => element.contains(e.position));

        if (containsBlack != -1) {
          final cloneDiag = [...element];
          final white = whitePositions[containsBlack];
          final shortedDiag = cellsBeforeSecondPos(cloneDiag, white.position);
          diags[key] = shortedDiag;
        }
      });
      var busyPositions = blackPositions
          .map((element) => element.position)
          .where((element) =>
      diags[Diag.bottomLeft]!.contains(element) ||
          diags[Diag.bottomRight]!.contains(element) ||
          (diags.containsKey(Diag.topRight) &&
              (diags[Diag.topRight]!.contains(element) ||
                  diags[Diag.topLeft]!.contains(element))))
          .toList();
      GameCell? nearEnemyPos = findTwiceEnemyDiagCells(busyPositions);

      return diags.map((d,p){
        var res = p.takeWhile((e)=>e!=nearEnemyPos && !whitePositions.map((k)=>k.position).contains(e)).toList();
        return MapEntry(d, res);
      }).values
          .expand((element) => element)
          // .takeWhile((value) => whitePositions.map((k)=>k.position).contains(value))
          .where((element) =>
              !blackPositions.map((y) => y.position).contains(element) &&
              !whitePositions.map((y) => y.position).contains(element))
          .toList();
    }
    // cells.forEach((element) {element.})
    return [];
  }

  List<GameCell> takeDiagCells(
      {required GameCell startPoint, required Diag diag, int length = 8}) {
    List<GameCell> freeCells = [];
    switch (diag) {
      case Diag.topLeft:
        freeCells.addAll(List.generate(
            length + 1,
            (index) => GameCell(
                row: startPoint.row - index,
                column: startPoint.column - index,
                cellColor: CellColor.black)));
      case Diag.topRight:
        freeCells.addAll(List.generate(
            length + 1,
            (index) => GameCell(
                row: startPoint.row - index,
                column: startPoint.column + index,
                cellColor: CellColor.black)));
      case Diag.bottomLeft:
        freeCells.addAll(List.generate(
            length + 1,
            (index) => GameCell(
                row: startPoint.row + index,
                column: startPoint.column - index,
                cellColor: CellColor.black)));
      case Diag.bottomRight:
        freeCells.addAll(List.generate(
            length + 1,
            (index) => GameCell(
                row: startPoint.row + index,
                column: startPoint.column + index,
                cellColor: CellColor.black)));
    }
    freeCells = freeCells.where((element) => cells.contains(element)).toList();
    freeCells = freeCells.skip(1).toList();
    return freeCells;
  }

  Diag defineDiag(GameCell startPoint, GameCell endPoint) {
    if (startPoint.row > endPoint.row && startPoint.column > endPoint.column) {
      return Diag.topLeft;
    } else if (startPoint.row > endPoint.row &&
        startPoint.column < endPoint.column) {
      return Diag.topRight;
    } else if (startPoint.row < endPoint.row &&
        startPoint.column > endPoint.column) {
      return Diag.bottomLeft;
    } else {
      return Diag.bottomRight;
    }
  }

  List<GameCell> cellsAfterSecondPos(List<GameCell> diag, GameCell secondPos) {
    List<GameCell> enemyPoints = [];

    bool needTake = false;
    for (var element in diag) {
      if (needTake) {
        enemyPoints.add(element);
      }
      if (element == secondPos) {
        needTake = true;
      }
    }

    return enemyPoints;
  }
  GameCell cellAfterSecondPos(Diag diag, GameCell secondPos) {
  switch(diag) {
    case Diag.topLeft:
      return GameCell(row: secondPos.row-1, column: secondPos.column-1, cellColor: CellColor.black);
    case Diag.topRight:
      return GameCell(row: secondPos.row-1, column: secondPos.column+1, cellColor: CellColor.black);

    case Diag.bottomLeft:
      return GameCell(row: secondPos.row+1, column: secondPos.column-1, cellColor: CellColor.black);

    case Diag.bottomRight:
      return GameCell(row: secondPos.row+1, column: secondPos.column+1, cellColor: CellColor.black);

  }

  }

  List<GameCell> cellsBeforeSecondPos(
      List<GameCell> diag, GameCell secondPoint) {
    List<GameCell> enemyPoints = [];
    bool needTake = false;
    for (var element in diag) {
      if (element == secondPoint) {
        needTake = true;
      }
      if (!needTake) {
        enemyPoints.add(element);
      }
    }
    return enemyPoints;
  }

  bool isNearByDiagCells(GameCell gameCell1, GameCell gameCell2) {
    final x = (gameCell1.row - gameCell2.row).abs();
    final y = (gameCell1.column - gameCell2.column).abs();
    // final x2 = (gameCell1.row - gameCell2.row).abs();
    // final y2 = (gameCell1.column - gameCell2.column).abs();
    // print("CDEVEWVEW x:${x} y:${y}");
    if (x == 1 && y == 1 ) {
      return true;
    }
    return false;
  }
  List<GameCell> sortPointsByDistantionPoint(GameCell gameCell,List<GameCell> cells){
    SplayTreeMap<double,GameCell> distancePoints = SplayTreeMap();
    for (var e in cells) {
      final distance = distanceBetweenPoints(gameCell, e);
      distancePoints.putIfAbsent(distance, ()=>e);
    }
    print("distancePoints $distancePoints");



    return distancePoints.values.toList();
  }
  double distanceBetweenPoints(GameCell point1,GameCell point2){
    return math.sqrt(math.pow(point1.column-point2.column, 2)+math.pow(point1.row-point2.row, 2));
  }
  GameCell? findTwiceEnemyDiagCells(List<GameCell> positions) {
    for (var e1 in positions) {
      for (var e2 in positions) {
        if(isNearByDiagCells(e1,e2)){
          return e1;
        }
      }}

    return null;
  }
  List<T> rotate<T>(List<T> list, int v) {
    if(list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }
  Map<Diag,List<GameCell>> groupByDiag(GameCell startPoint,List<GameCell> cells){
    final diags = <Diag,List<GameCell>>{};
    for (var cell in cells) {
      final diag = defineDiag(startPoint, cell);
      if(diags.containsKey(diag)){
        final diag_cells = diags[diag]!;
        diag_cells.add(cell);
        diags.update(diag, (k)=>diags[diag]!);
      }else{
        diags.putIfAbsent(diag, ()=>[cell]);
      }
    }
    return diags;
  }
  List<GameCell> getFreeCellsAfterAttack(Checker checker) {

    final Map<Diag, List<GameCell>> diags = {
      Diag.topLeft: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.topLeft,
          length: checker.isQueen ? 8 : 2),
      Diag.topRight: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.topRight,
          length: checker.isQueen ? 8 : 2),
      Diag.bottomLeft: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.bottomLeft,
          length: checker.isQueen ? 8 : 2),
      Diag.bottomRight: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.bottomRight,
          length: checker.isQueen ? 8 : 2),
    };
    var whitePoints = whitePositions
        .map((element) => element.position)
        .where((element) =>
    diags[Diag.bottomLeft]!.contains(element) ||
        diags[Diag.bottomRight]!.contains(element) ||
        diags[Diag.topLeft]!.contains(element) ||
        diags[Diag.topRight]!.contains(element))
        .toList();
    var blackPoints = blackPositions
        .map((element) => element.position)
        .where((element) =>
    diags[Diag.bottomLeft]!.contains(element) ||
        diags[Diag.bottomRight]!.contains(element) ||
        diags[Diag.topLeft]!.contains(element) ||
        diags[Diag.topRight]!.contains(element))
        .toList();
    if (checker.color == Colors.black) {


      var groupedEnemies = groupByDiag(checker.position, whitePoints);

      groupedEnemies = groupedEnemies.map((i,v) {
        final twiceEnemy = findTwiceEnemyDiagCells(v);
        var res =  checker.isQueen?sortPointsByDistantionPoint(checker.position, v):sortPointsByDistantionPoint(checker.position, v).reversed.toList();
        res = res.takeWhile((o)=>o!=twiceEnemy).toList();

        if(res.length>1){
          res = [res.first];
        }
        if(twiceEnemy!=null ){
          res = res.where((e)=>cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))!=e ).map((e)=>cellAfterSecondPos(i, e)).toList();
        }else if(!checker.isQueen){
          res = res.where((e)=>cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))!=e  && !blackPoints.contains(cellAfterSecondPos(i, e) )  ).map((e)=>cellAfterSecondPos(i, e)).toList();
        }else if(checker.isQueen){
          res = res.where((e)=> !blackPoints.contains(cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))) ).map((e)=>cellAfterSecondPos(i, e)).toList();

        } else{
          res = res.map((e)=>cellAfterSecondPos(i, e)).toList();
        }

        if(res.isNotEmpty && checker.isQueen){
          res.addAll(takeDiagCells(startPoint: res.last, diag: i));
          res = res.takeWhile((e)=>!whitePoints.contains(e)).toList();
        }
        res=res.takeWhile((e)=>!blackPoints.contains(cellAfterSecondPos(i, checker.position))).takeWhile((e)=>!blackPoints.contains(e)).where((e)=>e.column<=8&&e.row<=8 && e.column>=1&&e.row>=1 ).toList();

        return MapEntry(i, res);

      });

      return groupedEnemies.values.expand((e)=>e).toList();

      // freeCells = freeCells.where((element) => whitePositions.map((y)=>y.position).contains(element)).toList();
    } else if (checker.color == Colors.white) {

      var groupedEnemies = groupByDiag(checker.position, blackPoints);

      groupedEnemies = groupedEnemies.map((i,v) {
        var twiceEnemy = findTwiceEnemyDiagCells(v);

        var res =  checker.isQueen?sortPointsByDistantionPoint(checker.position, v):sortPointsByDistantionPoint(checker.position, v).reversed.toList();
        res = res.takeWhile((o)=>o!=twiceEnemy).toList();

        if(res.length>1){
          res = [res.first];
        }
        res = res.takeWhile((o)=>o!=twiceEnemy).toList();
        if(twiceEnemy!=null ){
          res = res.where((e)=>cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))!=e ).map((e)=>cellAfterSecondPos(i, e)).toList();
        }else if(!checker.isQueen){
          res = res.where((e)=>cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))!=e  && !whitePoints.contains(cellAfterSecondPos(i, e) )  ).map((e)=>cellAfterSecondPos(i, e)).toList();
        }else if(checker.isQueen){
          res = res.where((e)=> !whitePoints.contains(cellAfterSecondPos(i, cellAfterSecondPos(i, checker.position))) ).map((e)=>cellAfterSecondPos(i, e)).toList();

        }

        else{
          res = res.map((e)=>cellAfterSecondPos(i, e)).toList();
        }

        if(res.isNotEmpty && checker.isQueen && !blackPoints.contains(cellAfterSecondPos(i, checker.position))){
          res.addAll(takeDiagCells(startPoint: res.last, diag: i));
          res = res.takeWhile((e)=>!blackPoints.contains(e) ).toList();

        }
         res=res.takeWhile((e)=>!whitePoints.contains(cellAfterSecondPos(i, checker.position))).takeWhile((e)=>!whitePoints.contains(e)).where((e)=>e.column<=8&&e.row<=8 && e.column>=1&&e.row>=1 ).toList();

        return MapEntry(i, res);

      });
    print("12324323 ${groupedEnemies}");

      return groupedEnemies.values.expand((e)=>e).toList();
    }
    // cells.forEach((element) {element.})
    return [];
  }

  Checker? getKilledCheckersAfterAttack(
      Checker checker, GameCell firstPos, GameCell secondPos) {

    final Map<Diag, List<GameCell>> diags = {
      Diag.topLeft: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.topLeft,
          length: checker.isQueen ? 8 : 1),
      Diag.topRight: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.topRight,
          length: checker.isQueen ? 8 : 1),
      Diag.bottomLeft: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.bottomLeft,
          length: checker.isQueen ? 8 : 1),
      Diag.bottomRight: takeDiagCells(
          startPoint: checker.position,
          diag: Diag.bottomRight,
          length: checker.isQueen ? 8 : 1),
    };
    final diag = defineDiag(firstPos, secondPos);
   //  final freeCells = getFreeCells(checker);
   // diags[diag]!.retainWhere((element) => !freeCells.contains(element));
    diags[diag] = diags[diag]!.takeWhile((element) => element!=secondPos).toList();

    if (checker.color == Colors.white) {
      var blackEnemyPositions = blackPositions
          // .map((element) => element.position)
          .where((element) => diags[diag]!.contains(element.position) )
          .toList();
      if (blackEnemyPositions.isNotEmpty) {
        return blackEnemyPositions.last;
      }
    } else {
      var blackEnemyPositions = whitePositions
          // .map((element) => element.position)
          // .where((element) => diags[diag]!.contains(element.position) &&diags[diag]!.last!=element.position )
          .where((element) => diags[diag]!.contains(element.position)  )
          .toList();
      if (blackEnemyPositions.isNotEmpty) {
        return blackEnemyPositions.last;
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

  // bool hasOtherKiller(Checker? checker) {
  //   if (checker?.color == Colors.white) {
  //     final whitePositions = [...this.whitePositions];
  //     whitePositions.removeWhere((element) =>
  //         element.position.column == checker!.position.column &&
  //         element.position.row == checker.position.row);
  //     return whitePositions
  //         .any((element) => getFreeCellsAfterAttack(element).isNotEmpty);
  //   } else if (checker?.color == Colors.black) {
  //     final blackPositions = [...this.blackPositions];
  //     blackPositions.removeWhere((element) =>
  //         element.position.column == checker!.position.column &&
  //         element.position.row == checker!.position.row);
  //     return blackPositions
  //         .any((element) => getFreeCellsAfterAttack(element).isNotEmpty);
  //   }
  //   return false;
  // }

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
