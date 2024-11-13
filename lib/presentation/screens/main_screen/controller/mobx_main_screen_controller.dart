import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/models/checker.dart';
import '../../../../domain/models/game_cell.dart';
import '../../../../domain/models/game_field.dart';



part 'mobx_main_screen_controller.g.dart';

@lazySingleton
class MobxMainScreenController = _MobxMainScreenController
    with _$MobxMainScreenController;

abstract class _MobxMainScreenController with Store {
   Function (Color winner)? onGameOver;

  @observable
  GameField? _gameField;


  bool inited = false;
  @observable
  int timeCounter = 0;
  @observable
  Color? winner;
  @action
  Future<void> gameOver(Color winner)async {
    onGameOver?.call(winner);
    this.winner = winner;
  }

  Future<void> init() async {
    inited = false;

    _gameField = GameField(
        cells: initCells(),
        lightedPositions: ObservableList<GameCell>(),
        deadBlackPositions: ObservableList<Checker>(),
        deadWhitePositions: ObservableList<Checker>(),
        attackLightedPositions: ObservableList<GameCell>(),
        blackPositions: initCheckers(color: Colors.black).asObservable(),
        whitePositions: initCheckers(color: Colors.white).asObservable());
    print(_gameField?.cells);
    print(_gameField?.blackPositions.length);
    print(_gameField?.whitePositions.length);

    inited = true;
  }

  GameField get gameField => _gameField!;

  // void updateBlackChecker(int index,Checker checker){
  //   _gameField?.blackPositions[index] = checker;
  // }
  void nextSelectedBlackCheckerPosition(GameCell position) {
    final index =
        _gameField!.blackPositions.indexWhere((element) => element.isSelected);
    final checker = _gameField!.blackPositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    _gameField!.blackPositions[index] = checker.copy(position: position);
    unselectBlackCheckers();
    _gameField!.lightedPositions.clear();
    final killedChecker = _gameField!
        .getKilledCheckersAfterAttack(checker, firstPosition, secondPosition);
    gameField.killChecker(killedChecker);
    _gameField!.attackLightedPositions.clear();
    if (position.row == 1) {
      _gameField!.blackPositions[index] =
          checker.copy(isQueen: true, position: position);
    }
    if (killedChecker != null &&
        _gameField!
            .getFreeCellsAfterAttack(_gameField!.blackPositions[index])
            .isNotEmpty) {
      gameField.currentSide = Colors.black;
    } else {
      gameField.currentSide = Colors.white;
    }

  }
  Color? isWin(){
    if(gameField.deadBlackPositions.length==12){
      return Colors.white;
    }
    if(gameField.deadWhitePositions.length==12){
      return Colors.black;
    }
    return null;
  }

  Checker? getSelectedChecker() {
    final indexBlack =
        _gameField!.blackPositions.indexWhere((element) => element.isSelected);
    if (indexBlack != -1) {
      return gameField.blackPositions[indexBlack];
    }
    final indexWhite =
        _gameField!.whitePositions.indexWhere((element) => element.isSelected);
    if (indexWhite != -1) {
      return gameField.whitePositions[indexWhite];
    }
    return null;
  }

  void nextSelectedWhiteCheckerPosition(GameCell position) {
    final index =
        _gameField!.whitePositions.indexWhere((element) => element.isSelected);

    final checker = _gameField!.whitePositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    _gameField!.whitePositions[index] = checker.copy(position: position);
    unselectWhiteCheckers();
    _gameField!.lightedPositions.clear();
    var killedChecker = _gameField!
        .getKilledCheckersAfterAttack(checker, firstPosition, secondPosition);

    gameField.killChecker(killedChecker);
    _gameField!.attackLightedPositions.clear();
    // print("IS QUEEN ${checker.position}");

    if (position.row == 8) {
      _gameField!.whitePositions[index] =
          checker.copy(isQueen: true, position: position);
    }

    //Конец хода
    if (killedChecker != null &&
        _gameField!
            .getFreeCellsAfterAttack(_gameField!.whitePositions[index])
            .isNotEmpty) {
      gameField.currentSide = Colors.white;
    } else {
      gameField.currentSide = Colors.black;
    }

  }

  void selectBlackChecker(
    int index,
  ) {
    final checker = _gameField!.blackPositions[index];

    if (gameField.currentSide != Colors.black) {
      _gameField!.lightedPositions.clear();
      _gameField!.attackLightedPositions.clear();
      return;
    }
    unselectBlackCheckers();
    unselectWhiteCheckers();
    _gameField!.blackPositions[index] =
        _gameField!.blackPositions[index].copy(isSelected: true);
    _gameField!.lightedPositions.clear();
    _gameField!.attackLightedPositions.clear();
    _gameField!.attackLightedPositions.addAll(
        _gameField!.getFreeCellsAfterAttack(_gameField!.blackPositions[index]));
    if (_gameField!.attackLightedPositions.isEmpty) {
      _gameField!.lightedPositions
          .addAll(_gameField!.getFreeCells(_gameField!.blackPositions[index]));
    }

  }

  void selectWhiteChecker(
    int index,
  ) {
    // final checker =  _gameField!.whitePositions[index];

    if (gameField.currentSide != Colors.white) {
      _gameField!.lightedPositions.clear();
      _gameField!.attackLightedPositions.clear();
      return;
    }
    unselectWhiteCheckers();
    unselectBlackCheckers();
    _gameField!.whitePositions[index] =
        _gameField!.whitePositions[index].copy(isSelected: true);
    _gameField!.lightedPositions.clear();
    _gameField!.attackLightedPositions.clear();
    _gameField!.attackLightedPositions.addAll(
        _gameField!.getFreeCellsAfterAttack(_gameField!.whitePositions[index]));
    print("CWDVWEEW ${_gameField!.attackLightedPositions}");
    if (_gameField!.attackLightedPositions.isEmpty) {
      _gameField!.lightedPositions
          .addAll(_gameField!.getFreeCells(_gameField!.whitePositions[index]));
    }
    print("_gameField!.attackLightedPositions ${_gameField!.attackLightedPositions}");
    // print("${_gameField!.lightedPositions } ${_gameField!.attackLightedPositions}");
  }

  void unselectBlackCheckers() {
    for (int i = 0; i < _gameField!.blackPositions.length; i++) {
      _gameField!.blackPositions[i] =
          _gameField!.blackPositions[i].copy(isSelected: false);
    }
  }

  void unselectWhiteCheckers() {
    for (int i = 0; i < _gameField!.whitePositions.length; i++) {
      _gameField!.whitePositions[i] =
          _gameField!.whitePositions[i].copy(isSelected: false);
    }
  }

  List<Checker> initCheckers({
    required Color color,
  }) {
    final List<Checker> cells = [];

    if (color == Colors.black) {
      int row1 = 6;
      int row2 = 7;
      int row3 = 8;
      cells.addAll([
        Checker(
          isQueen: true,
            color: color,
            position:
                GameCell(row: row1, column: 2, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row1, column: 4, cellColor: CellColor.black)),
        Checker(
          isQueen: true,
            color: color,
            position:
            GameCell(row: row1, column: 6, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row1, column: 8, cellColor: CellColor.black))
      ]);
      cells.addAll([
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 1, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 5, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 7, cellColor: CellColor.black))
      ]);
      cells.addAll([
        // Checker(
        //     color: color,
        //     position:
        //     GameCell(row: row3, column: 2, cellColor: CellColor.black)),
        // Checker(
        //     color: color,
        //     position:
        //     GameCell(row: row3, column: 4, cellColor: CellColor.black)),
        // Checker(
        //     color: color,
        //     position:
        //     GameCell(row: row3, column: 6, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row3, column: 8, cellColor: CellColor.black))
      ]);
    }else{
      int row1 = 1;
      int row2 = 2;
      int row3 = 3;
      cells.addAll([
        // Checker(
        //     color: color,
        //     position:
        //     GameCell(row: row1, column: 1, cellColor: CellColor.black,)),
        Checker(
            color: color,
            position:
            GameCell(row: row1, column: 3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row1, column: 5, cellColor: CellColor.black)),
        // Checker(
        //     color: color,
        //     position:
        //     GameCell(row: row1, column: 7, cellColor: CellColor.black))
      ]);
      cells.addAll([
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 2, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 4, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 6, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row2, column: 8, cellColor: CellColor.black))
      ]);
      cells.addAll([
        Checker(
          isQueen: true,
            color: color,
            position:
            GameCell(row: row3+5, column: 1+3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row3, column: 3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
            GameCell(row: row3, column: 5, cellColor: CellColor.black)),
        Checker(
          isQueen: true,
            color: color,
            position:
            GameCell(row: row3, column: 7, cellColor: CellColor.black))
      ]);
    }
    // if (color == Colors.black) {
    //   for (int i = 6; i <= 8; i++) {
    //     final odd = i % 2 == 0;
    //     if (odd) {
    //       cells.addAll([
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 2, cellColor: CellColor.black)),
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 4, cellColor: CellColor.black)),
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 6, cellColor: CellColor.black)),
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 8, cellColor: CellColor.black))
    //       ]);
    //     } else {
    //       cells.addAll([
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 1, cellColor: CellColor.black)),
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 3, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 5, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 7, cellColor: CellColor.black))
    //       ]);
    //     }
    //   }
    // } else if (color == Colors.white) {
    //   for (int i = 1; i <= 3; i++) {
    //     final odd = i % 2 == 0;
    //     if (odd) {
    //       cells.addAll([
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 2, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 4, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 6, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 8, cellColor: CellColor.black))
    //       ]);
    //     } else {
    //       cells.addAll([
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 1, cellColor: CellColor.black)),
    //         Checker(
    //
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 3, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 5, cellColor: CellColor.black)),
    //         Checker(
    //             color: color,
    //             position:
    //                 GameCell(row: i, column: 7, cellColor: CellColor.black))
    //       ]);
    //     }
    //   }
    // }
    // return  cells.take(2).map((e) => e.copy(isQueen: true)).toList();
    return cells;
  }

  List<GameCell> initCells() {
    final List<GameCell> cells = [];
    for (int i = 0; i < 8; i++) {
      final odd = i % 2 == 0 ? CellColor.black : CellColor.white;
      final not_odd = i % 2 != 0 ? CellColor.black : CellColor.white;
      cells.addAll([
        GameCell(row: i + 1, column: 1, cellColor: odd),
        GameCell(row: i + 1, column: 2, cellColor: not_odd),
        GameCell(row: i + 1, column: 3, cellColor: odd),
        GameCell(row: i + 1, column: 4, cellColor: not_odd),
        GameCell(row: i + 1, column: 5, cellColor: odd),
        GameCell(row: i + 1, column: 6, cellColor: not_odd),
        GameCell(row: i + 1, column: 7, cellColor: odd),
        GameCell(
          row: i + 1,
          column: 8,
          cellColor: not_odd,
        )
      ]);
    }
    return cells;
  }
}
