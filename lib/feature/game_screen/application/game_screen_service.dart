import 'dart:collection';
import 'dart:ui';
import 'dart:math' as math;

import 'package:checker/feature/game_screen/application/igame_screen_service.dart';
import 'package:checker/feature/game_screen/domain/models/checker_position.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enum/diag.dart';
import '../domain/models/checker.dart';
import '../presentation/controller/game_screen_controller.dart';
@LazySingleton(as: IGameScreenService)
class GameScreenService extends IGameScreenService{
  @override
  CheckerPosition getPosition(GameCell checker, double cellWidth) {
    final halfWidth = cellWidth;
    if (checker.column >= 1 && checker.column <= 8) {
      return CheckerPosition(
          x: halfWidth * checker.column, y: halfWidth * checker.row);
    } else {
      throw Exception("Не корректный столбец");
    }
  }

  @override
  Color? isWin( List<Checker>  deadBlackPositions, List<Checker>  deadWhitePositions) {
    if (deadBlackPositions.length == 12) {
      return Colors.white;
    }
    if (deadWhitePositions.length == 12) {
      return Colors.black;
    }
    return null;
  }

  @override
  GameCell? findTwiceEnemyDiagCells(List<GameCell> positions) {
    for (var e1 in positions) {
      for (var e2 in positions) {
        if (isNearByDiagCells(e1, e2)) {
          return e1;
        }
      }
    }

    return null;
  }

  @override
  bool isNearByDiagCells(GameCell gameCell1, GameCell gameCell2) {
    final x = (gameCell1.row - gameCell2.row).abs();
    final y = (gameCell1.column - gameCell2.column).abs();
    // final x2 = (gameCell1.row - gameCell2.row).abs();
    // final y2 = (gameCell1.column - gameCell2.column).abs();
    // print("CDEVEWVEW x:${x} y:${y}");
    if (x == 1 && y == 1) {
      return true;
    }
    return false;
  }
  List<GameCell> getFreeCells( {   required List<GameCell> cells,
    required  Checker checker,
    required  List<Checker> blackPositions,
    required List<Checker> whitePositions,}) {
    final Map<Diag, List<GameCell>> diags = {};

    if (checker.color == Colors.black) {
      if (checker.isQueen) {
        diags.putIfAbsent(
            Diag.topLeft,
                () => takeDiagCells(
                  cells: cells,
                startPoint: checker.position, diag: Diag.topLeft, length: 8));
        diags.putIfAbsent(
            Diag.topRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position, diag: Diag.topRight, length: 8));
        diags.putIfAbsent(
            Diag.bottomLeft,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 8));
        diags.putIfAbsent(
            Diag.bottomRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 8));
      } else {
        diags.putIfAbsent(
            Diag.topLeft,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position, diag: Diag.topLeft, length: 1));
        diags.putIfAbsent(
            Diag.topRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position, diag: Diag.topRight, length: 1));

        // freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        // freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      }
      diags.forEach((key, element) {
        final containsBlack = blackPositions
            .indexWhere((e) => element.contains(e.position));

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
      GameCell? nearEnemyPos = findTwiceEnemyDiagCells(busyPositions);

      return diags
          .map((d, p) {
        var res = p.takeWhile((e) => e != nearEnemyPos).toList();

        return MapEntry(d, res);
      })
          .values
          .expand((element) => element)
          .takeWhile((value) => value != nearEnemyPos)
          .where((element) =>
      !blackPositions
          .map((y) => y.position)
          .contains(element) &&
          !whitePositions
              .map((y) => y.position)
              .contains(element))
          .toList();
    } else if (checker.color == Colors.white) {
      if (checker.isQueen) {
        diags.putIfAbsent(
            Diag.topLeft,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position, diag: Diag.topLeft, length: 8));
        diags.putIfAbsent(
            Diag.topRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position, diag: Diag.topRight, length: 8));
        diags.putIfAbsent(
            Diag.bottomLeft,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 8));
        diags.putIfAbsent(
            Diag.bottomRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 8));
      } else {
        diags.putIfAbsent(
            Diag.bottomLeft,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomRight,
                length: 1));
        diags.putIfAbsent(
            Diag.bottomRight,
                () => takeDiagCells(
                    cells: cells,

                startPoint: checker.position,
                diag: Diag.bottomLeft,
                length: 1));

        // freeCells = takeDiagCells(startPoint: checker.position, diag: Diag.topLeft,length: 1);
        // freeCells.addAll(takeDiagCells(startPoint: checker.position, diag: Diag.topRight,length: 1));
      }
      diags.forEach((key, element) {
        final containsBlack = whitePositions
            .indexWhere((e) => element.contains(e.position));

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

      return diags
          .map((d, p) {
        var res = p
            .takeWhile((e) =>
        e != nearEnemyPos &&
            !whitePositions
                .map((k) => k.position)
                .contains(e))
            .toList();
        return MapEntry(d, res);
      })
          .values
          .expand((element) => element)
      // .takeWhile((value) => whitePositions.map((k)=>k.position).contains(value))
          .where((element) =>
      !blackPositions
          .map((y) => y.position)
          .contains(element) &&
          !whitePositions
              .map((y) => y.position)
              .contains(element))
          .toList();
    }
    // cells.forEach((element) {element.})
    return [];
  }
  List<GameCell> takeDiagCells(
      {required List<GameCell> cells,required GameCell startPoint, required Diag diag, int length = 8}) {
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
    freeCells = freeCells
        .where((element) => cells.contains(element))
        .toList();
    freeCells = freeCells.skip(1).toList();
    return freeCells;
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
  Checker? getKilledCheckersAfterAttack(
      {   required  List<Checker> blackPositions,
        required List<Checker> whitePositions,required List<GameCell> cells,required Checker checker, required GameCell firstPos, required GameCell secondPos}) {
    final Map<Diag, List<GameCell>> diags = {
      Diag.topLeft: takeDiagCells(
          cells:cells,
          startPoint: checker.position,
          diag: Diag.topLeft,
          length: checker.isQueen ? 8 : 1),
      Diag.topRight:takeDiagCells(
          cells:cells,
          startPoint: checker.position,
          diag: Diag.topRight,
          length: checker.isQueen ? 8 : 1),
      Diag.bottomLeft: takeDiagCells(
          cells:cells,
          startPoint: checker.position,
          diag: Diag.bottomLeft,
          length: checker.isQueen ? 8 : 1),
      Diag.bottomRight: takeDiagCells(
          cells:cells,
          startPoint: checker.position,
          diag: Diag.bottomRight,
          length: checker.isQueen ? 8 : 1),
    };
    final diag = defineDiag(firstPos, secondPos);
    //  final freeCells = getFreeCells(checker);
    // diags[diag]!.retainWhere((element) => !freeCells.contains(element));
    diags[diag] =
        diags[diag]!.takeWhile((element) => element != secondPos).toList();

    if (checker.color == Colors.white) {
      var blackEnemyPositions = blackPositions
      // .map((element) => element.position)
          .where((element) => diags[diag]!.contains(element.position))
          .toList();
      if (blackEnemyPositions.isNotEmpty) {
        return blackEnemyPositions.last;
      }
    } else {
      var blackEnemyPositions = whitePositions
      // .map((element) => element.position)
      // .where((element) => diags[diag]!.contains(element.position) &&diags[diag]!.last!=element.position )
          .where((element) => diags[diag]!.contains(element.position))
          .toList();
      if (blackEnemyPositions.isNotEmpty) {
        return blackEnemyPositions.last;
      }
    }

    return null;
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
  List<GameCell> getFreeCellsAfterAttack({required Checker checker,required List<GameCell> cells, required  List<Checker> blackPositions,
    required List<Checker> whitePositions,}) {
    final Map<Diag, List<GameCell>> diags = {
      Diag.topLeft: takeDiagCells(
cells: cells,
          startPoint: checker.position,
          diag: Diag.topLeft,
          length: checker.isQueen ? 8 : 2),
      Diag.topRight: takeDiagCells(
        cells: cells,
          startPoint: checker.position,
          diag: Diag.topRight,
          length: checker.isQueen ? 8 : 2),
      Diag.bottomLeft: takeDiagCells(
        cells: cells,
          startPoint: checker.position,
          diag: Diag.bottomLeft,
          length: checker.isQueen ? 8 : 2),
      Diag.bottomRight: takeDiagCells(
        cells: cells,
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
      var groupedEnemies = groupByDiag(startPoint:checker.position,cells:  whitePoints);

      groupedEnemies = groupedEnemies.map((i, v) {
        final twiceEnemy = findTwiceEnemyDiagCells(v);
        var res = checker.isQueen
            ? sortPointsByDistantionPoint(gameCell:  checker.position, cells: v)
            : sortPointsByDistantionPoint(gameCell:  checker.position, cells: v)
            .reversed
            .toList();
        res = res.takeWhile((o) => o != twiceEnemy).toList();

        if (res.length > 1) {
          res = [res.first];
        }
        if (twiceEnemy != null) {
          res = res
              .where((e) =>
          cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position)) !=
              e)
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else if (!checker.isQueen) {
          res = res
              .where((e) =>
          cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position)) !=
              e &&
              !blackPoints.contains(cellAfterSecondPos(i, e)))
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else if (checker.isQueen) {
          res = res
              .where((e) => !blackPoints.contains(cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position))))
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else {
          res = res.map((e) => cellAfterSecondPos(i, e)).toList();
        }

        if (res.isNotEmpty && checker.isQueen) {
          res.addAll(takeDiagCells(startPoint: res.last, diag: i, cells:cells,));
          res = res.takeWhile((e) => !whitePoints.contains(e)).toList();
        }
        res = res
            .takeWhile((e) =>
        !blackPoints.contains(cellAfterSecondPos(i, checker.position)))
            .takeWhile((e) => !blackPoints.contains(e))
            .where((e) =>
        e.column <= 8 && e.row <= 8 && e.column >= 1 && e.row >= 1)
            .toList();

        return MapEntry(i, res);
      });

      return groupedEnemies.values.expand((e) => e).where((e)=>!whitePoints.contains(e) && !blackPoints.contains(e)).toList();

      // freeCells = freeCells.where((element) => whitePositions.map((y)=>y.position).contains(element)).toList();
    } else if (checker.color == Colors.white) {
      var groupedEnemies = groupByDiag(startPoint:  checker.position,cells:  blackPoints);

      groupedEnemies = groupedEnemies.map((i, v) {
        var twiceEnemy = findTwiceEnemyDiagCells(v);

        var res = checker.isQueen
            ? sortPointsByDistantionPoint(gameCell:  checker.position, cells: v)
            : sortPointsByDistantionPoint(gameCell:  checker.position, cells: v)
            .reversed
            .toList();
        res = res.takeWhile((o) => o != twiceEnemy).toList();

        if (res.length > 1) {
          res = [res.first];
        }
        res = res.takeWhile((o) => o != twiceEnemy).toList();
        if (twiceEnemy != null) {
          res = res
              .where((e) =>
          cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position)) !=
              e)
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else if (!checker.isQueen) {
          res = res
              .where((e) =>
          cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position)) !=
              e &&
              !whitePoints.contains(cellAfterSecondPos(i, e)))
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else if (checker.isQueen) {
          res = res
              .where((e) => !whitePoints.contains(cellAfterSecondPos(
              i, cellAfterSecondPos(i, checker.position))))
              .map((e) => cellAfterSecondPos(i, e))
              .toList();
        } else {
          res = res.map((e) => cellAfterSecondPos(i, e)).toList();
        }

        if (res.isNotEmpty &&
            checker.isQueen &&
            !blackPoints.contains(cellAfterSecondPos(i, checker.position))) {
          res.addAll(takeDiagCells(startPoint: res.last, diag: i,cells: cells));
          res = res.takeWhile((e) => !blackPoints.contains(e)).toList();
        }
        res = res
            .takeWhile((e) =>
        !whitePoints.contains(cellAfterSecondPos(i, checker.position)))
            .takeWhile((e) => !whitePoints.contains(e))
            .where((e) =>
        e.column <= 8 && e.row <= 8 && e.column >= 1 && e.row >= 1)
            .toList();

        return MapEntry(i, res);
      });
      print("12324323 ${groupedEnemies}");

      return groupedEnemies.values.expand((e) => e).where((e)=>!whitePoints.contains(e) && !blackPoints.contains(e)).toList();
    }
    // cells.forEach((element) {element.})
    return [];
  }
  Map<Diag, List<GameCell>> groupByDiag(
      {required GameCell startPoint, required List<GameCell> cells}) {
    final diags = <Diag, List<GameCell>>{};
    for (var cell in cells) {
      final diag = defineDiag(startPoint, cell);
      if (diags.containsKey(diag)) {
        final diag_cells = diags[diag]!;
        diag_cells.add(cell);
        diags.update(diag, (k) => diags[diag]!);
      } else {
        diags.putIfAbsent(diag, () => [cell]);
      }
    }
    return diags;
  }
  List<GameCell> sortPointsByDistantionPoint(
      {required GameCell gameCell,required  List<GameCell> cells}) {
    SplayTreeMap<double, GameCell> distancePoints = SplayTreeMap();
    for (var e in cells) {
      final distance = distanceBetweenPoints(gameCell, e);
      distancePoints.putIfAbsent(distance, () => e);
    }

    return distancePoints.values.toList();
  }
  double distanceBetweenPoints(GameCell point1, GameCell point2) {
    return math.sqrt(math.pow(point1.column - point2.column, 2) +
        math.pow(point1.row - point2.row, 2));
  }
  GameCell cellAfterSecondPos(Diag diag, GameCell secondPos) {
    switch (diag) {
      case Diag.topLeft:
        return GameCell(
            row: secondPos.row - 1,
            column: secondPos.column - 1,
            cellColor: CellColor.black);
      case Diag.topRight:
        return GameCell(
            row: secondPos.row - 1,
            column: secondPos.column + 1,
            cellColor: CellColor.black);

      case Diag.bottomLeft:
        return GameCell(
            row: secondPos.row + 1,
            column: secondPos.column - 1,
            cellColor: CellColor.black);

      case Diag.bottomRight:
        return GameCell(
            row: secondPos.row + 1,
            column: secondPos.column + 1,
            cellColor: CellColor.black);
    }
  }

}