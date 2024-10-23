import 'package:checker/presentation/domain/models/game_field.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/models/checker.dart';
import '../../../domain/models/game_cell.dart';

part 'mobx_main_screen_controller.g.dart';

@lazySingleton
class MobxMainScreenController = _MobxMainScreenController
    with _$MobxMainScreenController;

abstract class _MobxMainScreenController with Store {
  @observable
  GameField? _gameField;
  bool inited = false;

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
  GameField get gameField =>_gameField!;
  // void updateBlackChecker(int index,Checker checker){
  //   _gameField?.blackPositions[index] = checker;
  // }
  void nextSelectedBlackCheckerPosition(GameCell position){
    final index = _gameField!.blackPositions.indexWhere((element) => element.isSelected);
    final checker =  _gameField!.blackPositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    _gameField!.blackPositions[index] = checker.copy(position: position);
    unselectBlackCheckers();
    _gameField!.lightedPositions.clear();
    final killedChecker = _gameField!.getKilledCheckersAfterAttack(checker, firstPosition, secondPosition);
    gameField.killChecker(killedChecker);
    _gameField!.attackLightedPositions.clear();
    if(killedChecker!=null && _gameField!.getFreeCellsAfterAttack(  _gameField!.whitePositions[index] ).isNotEmpty){
      gameField.currentSide = Colors.black;
    }else{
      gameField.currentSide = Colors.white;

    }
  }
  Checker? getSelectedChecker(){
    final indexBlack = _gameField!.blackPositions.indexWhere((element) => element.isSelected);
    if(indexBlack!=-1){
      return gameField.blackPositions[indexBlack];
    }
    final indexWhite = _gameField!.whitePositions.indexWhere((element) => element.isSelected);
    if(indexWhite!=-1){
      return gameField.whitePositions[indexWhite];
    }
    return null;
  }
  void nextSelectedWhiteCheckerPosition(GameCell position){
    final index = _gameField!.whitePositions.indexWhere((element) => element.isSelected);

    final checker =  _gameField!.whitePositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    _gameField!.whitePositions[index] = checker.copy(position: position);
    unselectWhiteCheckers();
    _gameField!.lightedPositions.clear();
    final killedChecker = _gameField!.getKilledCheckersAfterAttack(checker, firstPosition, secondPosition);
    gameField.killChecker(killedChecker);
    _gameField!.attackLightedPositions.clear();
    if(killedChecker!=null &&_gameField!.getFreeCellsAfterAttack(  _gameField!.whitePositions[index] ).isNotEmpty){
      gameField.currentSide = Colors.white;
    }else{
      gameField.currentSide = Colors.black;

    }
  }
  void selectBlackChecker(int index,){
    final checker =  _gameField!.blackPositions[index];

    if(gameField.currentSide!=Colors.black ){
      _gameField!.lightedPositions.clear();
      _gameField!.attackLightedPositions.clear();
      return;
    }
   unselectBlackCheckers();
   _gameField!.blackPositions[index] =   _gameField!.blackPositions[index].copy(isSelected: true);
   _gameField!.lightedPositions.clear();
   _gameField!.attackLightedPositions.clear();
   _gameField!.attackLightedPositions.addAll( _gameField!.getFreeCellsAfterAttack(  _gameField!.blackPositions[index] ) );
   if( _gameField!.attackLightedPositions.isEmpty){
     _gameField!.lightedPositions.addAll( _gameField!.getFreeCells(  _gameField!.blackPositions[index] ) );
   }

  }
  void selectWhiteChecker(int index,){
    final checker =  _gameField!.whitePositions[index];

    if(gameField.currentSide!=Colors.white ){
      _gameField!.lightedPositions.clear();
      _gameField!.attackLightedPositions.clear();
      return;
    }
    unselectBlackCheckers();
    _gameField!.whitePositions[index] =   _gameField!.whitePositions[index].copy(isSelected: true);
    _gameField!.lightedPositions.clear();
    _gameField!.attackLightedPositions.clear();
    _gameField!.attackLightedPositions.addAll( _gameField!.getFreeCellsAfterAttack(  _gameField!.whitePositions[index] ) );
    if( _gameField!.attackLightedPositions.isEmpty){
      _gameField!.lightedPositions.addAll( _gameField!.getFreeCells(  _gameField!.whitePositions[index] ) );

    }

  }
  void unselectBlackCheckers(){
    for (int i = 0;i<_gameField!.blackPositions.length;i++){
      _gameField!.blackPositions[i] = _gameField!.blackPositions[i].copy(isSelected: false);
    }
  }
  void unselectWhiteCheckers(){
    for (int i = 0;i<_gameField!.whitePositions.length;i++){
      _gameField!.whitePositions[i] = _gameField!.whitePositions[i].copy(isSelected: false);
    }
  }

  List<Checker> initCheckers({
    required Color color,
  }) {
    final List<Checker> cells = [];
    if (color == Colors.black) {
      for (int i = 6; i <= 8; i++) {
        final odd = i % 2 == 0;
        if (odd) {
          cells.addAll([
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 2, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 4, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 6, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 8, cellColor: CellColor.black))
          ]);
        } else {
          cells.addAll([
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 1, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 3, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 5, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 7, cellColor: CellColor.black))
          ]);
        }
      }
    } else if (color == Colors.white) {
      for (int i = 1; i <= 3; i++) {
        final odd = i % 2 == 0;
        if (odd) {
          cells.addAll([
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 2, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 4, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 6, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 8, cellColor: CellColor.black))
          ]);
        } else {
          cells.addAll([
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 1, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 3, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 5, cellColor: CellColor.black)),
            Checker(
                color: color,
                position:
                    GameCell(row: i, column: 7, cellColor: CellColor.black))
          ]);
        }
      }
    }
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
