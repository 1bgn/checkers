import 'package:flutter/material.dart';

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


      return diags.values
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


      print("ittt");
      return diags.values
          .expand((element) => element)
          .takeWhile((value) => value != nearEnemyPos)
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

    if (checker.color == Colors.black) {
      var whiteEnemyPositions = whitePositions
          .map((element) => element.position)
          .where((element) =>
              diags[Diag.bottomLeft]!.contains(element) ||
              diags[Diag.bottomRight]!.contains(element) ||
              diags[Diag.topLeft]!.contains(element) ||
              diags[Diag.topRight]!.contains(element))
          .toList();
      // final nearEnemy = findTwiceEnemyDiagCells(whiteEnemyPositions);
      //       whiteEnemyPositions =
      //           whiteEnemyPositions.takeWhile((value) => value != nearEnemy).toList();

      var attackDiags = whiteEnemyPositions
          .map((e) => defineDiag(checker.position, e))
          .map((e) => diags[e])
          .toList();
      print("CDSVDSV ${attackDiags}");
      List<GameCell> cellsAfterAttack = [];

      for (int i = 0; i < whiteEnemyPositions.length; i++) {
        final enemy = whiteEnemyPositions[i];
        var attackDiag = cellsAfterSecondPos(attackDiags[i]!, enemy);

        cellsAfterAttack.addAll(attackDiag);
      }

      cellsAfterAttack = cellsAfterAttack
          .where((element) => !whitePositions
              .map((element) => element.position)
              .contains(element))
          .toList();
      print("yyyy $cellsAfterAttack");
      cellsAfterAttack = cellsAfterAttack
          .where((element) =>
              cells.contains(element) &&
              !blackPositions.map((e) => e.position).contains(element) &&
              !whitePositions.map((e) => e.position).contains(element))
          .toList();

      return cellsAfterAttack;

      // freeCells = freeCells.where((element) => whitePositions.map((y)=>y.position).contains(element)).toList();
    } else if (checker.color == Colors.white) {
      var blackEnemyPositions = blackPositions
          .map((element) => element.position)
          .where((element) =>
              diags[Diag.bottomLeft]!.contains(element) ||
              diags[Diag.bottomRight]!.contains(element) ||
              diags[Diag.topLeft]!.contains(element) ||
              diags[Diag.topRight]!.contains(element))
          .toList();
      final nearEnemy = findTwiceEnemyDiagCells(blackEnemyPositions);
      if(nearEnemy!=null){
        blackEnemyPositions =
            blackEnemyPositions.takeWhile((value) => value != nearEnemy).toList();
      }
      // for (int i = 0; i < blackEnemyPositions.length; i++) {
      //   if (i + 1 < blackEnemyPositions.length) {
      //     final g1 = blackEnemyPositions[i];
      //     final g2 = blackEnemyPositions[i + 1];
      //     if (isNearByDiagCells(g1, g2)) {
      //       blackEnemyPositions =
      //           blackEnemyPositions.takeWhile((value) => value != g1).toList();
      //     }
      //   }
      // }
      var attackDiags = blackEnemyPositions
          .map((e) => defineDiag(checker.position, e))
          .map((e) => diags[e])
          .toList();
      // attackDiags.removeWhere((element) => whitePositions.)

      List<GameCell> cellsAfterAttack = [];
      for (int i = 0; i < blackEnemyPositions.length; i++) {
        final enemy = blackEnemyPositions[i];
        final attackDiag = cellsAfterSecondPos(attackDiags[i]!, enemy);
        cellsAfterAttack.addAll(attackDiag);
      }
      diags.forEach((key, element) {
        final containsWhite =
            whitePositions.indexWhere((e) => element.contains(e.position));

        if (containsWhite != -1) {
          final cloneDiag = [...element];
          final white = whitePositions[containsWhite];
          final shortedDiag = cellsBeforeSecondPos(cloneDiag, white.position);
          diags[key] = shortedDiag;
        }
      });
      cellsAfterAttack
          .where((element) => !whitePositions
              .map((element) => element.position)
              .contains(element))
          .toList();
      cellsAfterAttack = cellsAfterAttack
          .where((element) =>
              cells.contains(element) &&
              !blackPositions.map((e) => e.position).contains(element) &&
              !whitePositions.map((e) => e.position).contains(element))
          .toList();
      return cellsAfterAttack;
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
