import 'dart:async';
import 'dart:collection';

import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/application/igame_screen_service.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/game_screen_state.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/online_game_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../../common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import '../../../../common/game_session_feature/domain/model/sender_websocket_event_object.dart';
import '../../domain/models/checker.dart';
import '../../domain/models/checker_position.dart';
import '../../domain/models/game_cell.dart';

class OnlineGameScreenController extends Cubit<OnlineGameScreenState> {
  OnlineGameScreenController(this._gameScreenService)
      : super(const OnlineGameScreenState());
  final IGameScreenService _gameScreenService;

  void nextTime() {
    emit(state.copyWith(timeCounter: state.timeCounter + 1));
  }
  Future<void> listenGameSession(ConnectToGame connectionToGame, StreamController<ReceiveWebsocketEvent> connection) async {
   final sender = await _gameScreenService.listenGameSession(connectionToGame, connection);
   emit(state.copyWith(sender: sender));
  }
  void updateGameSession(GameSession gameSession){
    print("GAMEFIELD ${gameSession.gameField.lightedPositions}");
    emit(state.copyWith(gameField: gameSession.gameField,));
  }
  Future<OnlineGameScreenState> init(
      GameSession gameSession, GameConnection gameConnection) async {
    emit(state.copyWith(isLoading: true,reciever: StreamController()));
    emit(state.copyWith(
      opponentUser: gameConnection.sideColor == Colors.white
          ? gameSession.gameSessionItem.blackGamePlayer
          : gameSession.gameSessionItem.whiteGamePlayer,
        gameSession: gameSession.copyWith(
            gameSessionItem: gameSession.gameSessionItem.copyWith(
                whiteGamePlayer: gameConnection.sideColor == Colors.white
                    ? _gameScreenService.getCurrentUser()
                    : null,
            blackGamePlayer: gameConnection.sideColor == Colors.black
                ? _gameScreenService.getCurrentUser()
                : null))));

    _deployCurrentSession(gameSession);
    emit(state.copyWith(colorCurrentUser: gameConnection.sideColor));
    emit(state.copyWith(isLoading: false, isUploaded: true));
    return state;
  }

  void _deployCurrentSession(GameSession gameSession) {
    emit(state.copyWith(

      gameField: gameSession.gameField,
      currentUser: _gameScreenService.getCurrentUser(),
    ));
  }

  GameField get gameField => state.gameField;

  GameField nextSelectedBlackCheckerPosition(GameCell position) {
    final index =
        gameField.blackPositions.indexWhere((element) => element.isSelected);

    final checker = gameField.blackPositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    final blackPositions = [...gameField.blackPositions];
    blackPositions[index] = checker.copyWith(position: position);
    emit(state.copyWith(
        gameField: gameField
            .copyWith(blackPositions: blackPositions, lightedPositions: [])));
    // unselectWhiteCheckers();
    // state.gameField!.lightedPositions.clear();
    var killedChecker = _gameScreenService.getKilledCheckersAfterAttack(
        checker: checker,
        firstPos: firstPosition,
        secondPos: secondPosition,
        cells: gameField.cells,
        whitePositions: gameField.whitePositions,
        blackPositions: gameField.blackPositions);

    killChecker(killedChecker);
    emit(state.copyWith(
        gameField: state.gameField.copyWith(attackLightedPositions: [])));

    if (position.row == 1) {
      blackPositions[index] =
          checker.copyWith(isQueen: true, position: position);
      emit(state.copyWith(
          gameField: state.gameField.copyWith(blackPositions: blackPositions)));
    }

    //Конец хода
    unselectBlackCheckers();
    if (killedChecker != null &&
        _gameScreenService
            .getFreeCellsAfterAttack(
                checker: gameField.blackPositions[index],
                whitePositions: gameField.whitePositions,
                blackPositions: gameField.blackPositions,
                cells: gameField.cells)
            .isNotEmpty) {
      emit(state.copyWith(
          gameField: state.gameField.copyWith(currentSide: Colors.black)));
    } else {
      emit(state.copyWith(
          gameField: state.gameField.copyWith(currentSide: Colors.white)));
    }

    return state.gameField;

  }

  void upgradeGameField(){
    state.sender?.add(WebsocketGameSessionEventSession(eventType: SenderWebsocketEventType.UpdateSessionState,gameSession:state.gameSession.copyWith(gameField: state.gameField,)));

  }
  Checker? getSelectedChecker() {
    final indexBlack = state.gameField.blackPositions
        .indexWhere((element) => element.isSelected);
    if (indexBlack != -1) {
      return state.gameField.blackPositions[indexBlack];
    }
    final indexWhite = state.gameField!.whitePositions
        .indexWhere((element) => element.isSelected);
    if (indexWhite != -1) {
      return state.gameField.whitePositions[indexWhite];
    }
    return null;
  }

  CheckerPosition getPosition(GameCell checker, double cellWidth) {
    return _gameScreenService.getPosition(checker, cellWidth);
  }

  void killChecker(Checker? checker) {
    if (checker?.color == Colors.white) {
      final whitePositions = [...gameField.whitePositions];
      whitePositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker.position.row);

      emit(state.copyWith(
          gameField: state.gameField.copyWith(
              whitePositions: whitePositions,
              deadWhitePositions: [
            ...state.gameField.deadWhitePositions,
            checker!
          ])));
    }
    if (checker?.color == Colors.black) {
      final blackPositions = [...state.gameField.blackPositions];

      blackPositions.removeWhere((element) =>
          element.position.column == checker!.position.column &&
          element.position.row == checker.position.row);
      emit(state.copyWith(
          gameField: state.gameField.copyWith(
              blackPositions: blackPositions,
              deadBlackPositions: [
            ...state.gameField.deadWhitePositions,
            checker!
          ])));
    }
  }

  GameField nextSelectedWhiteCheckerPosition(GameCell position) {
    final index = state.gameField.whitePositions
        .indexWhere((element) => element.isSelected);

    final checker = state.gameField.whitePositions[index];
    final firstPosition = checker.position;
    final secondPosition = position;
    final whitePositions = [...state.gameField.whitePositions];
    whitePositions[index] = checker.copyWith(position: position);
    emit(state.copyWith(
        gameField: state.gameField
            .copyWith(whitePositions: whitePositions, lightedPositions: [])));
    // unselectWhiteCheckers();
    // state.gameField!.lightedPositions.clear();
    var killedChecker = _gameScreenService.getKilledCheckersAfterAttack(
        checker: checker,
        firstPos: firstPosition,
        secondPos: secondPosition,
        cells: gameField.cells,
        blackPositions: gameField.blackPositions,
        whitePositions: gameField.whitePositions);

    killChecker(killedChecker);
    emit(state.copyWith(
        gameField: state.gameField.copyWith(attackLightedPositions: [])));

    if (position.row == 8) {
      whitePositions[index] =
          checker.copyWith(isQueen: true, position: position);
      emit(state.copyWith(
          gameField: state.gameField.copyWith(whitePositions: whitePositions)));
    }

    //Конец хода
    unselectWhiteCheckers();
    if (killedChecker != null &&
        _gameScreenService
            .getFreeCellsAfterAttack(
                checker: gameField.whitePositions[index],
                cells: gameField.cells,
                blackPositions: gameField.blackPositions,
                whitePositions: gameField.whitePositions)
            .isNotEmpty) {
      emit(state.copyWith(
          gameField: state.gameField.copyWith(currentSide: Colors.white)));
    } else {
      emit(state.copyWith(
          gameField: state.gameField.copyWith(currentSide: Colors.black)));
    }
    return state.gameField;
  }

  void selectBlackChecker(
    int index,
  ) {
    if (state.gameField.currentSide != Colors.black) {
      emit(state.copyWith(
          gameField: state.gameField
              .copyWith(attackLightedPositions: [], lightedPositions: [])));
      return;
    }
    unselectWhiteCheckers();
    unselectBlackCheckers();
    final canOtherAttack = anyHasAttack(index);
    if (canOtherAttack != null && canOtherAttack != -1) {
      selectBlackChecker(canOtherAttack);
      return;
    }
    final blackPositions = [...state.gameField.blackPositions];
    blackPositions[index] = blackPositions[index].copyWith(isSelected: true);
    emit(state.copyWith(
        gameField: state.gameField.copyWith(
            blackPositions: blackPositions,
            lightedPositions: [],
            attackLightedPositions: _gameScreenService.getFreeCellsAfterAttack(
                checker: state.gameField.blackPositions[index],
                whitePositions: gameField.whitePositions,
                blackPositions: gameField.blackPositions,
                cells: gameField.cells))));
    if (state.gameField.attackLightedPositions.isEmpty) {
      emit(state.copyWith(
          gameField: state.gameField.copyWith(
              lightedPositions: _gameScreenService.getFreeCells(
                  cells: state.gameField.cells,
                  checker: state.gameField.blackPositions[index],
                  whitePositions: state.gameField.whitePositions,
                  blackPositions: state.gameField.blackPositions))));
    }
    print(
        "_gameField!.attackLightedPositions ${state.gameField!.attackLightedPositions}");
    // print("${_gameField!.lightedPositions } ${_gameField!.attackLightedPositions}");
  }

  int? anyHasAttack(int checkerId) {
    final positions = gameField.currentSide == Colors.white
        ? [...gameField.whitePositions]
        : [...gameField.blackPositions];
    // int index = positions.indexWhere((e)=>e==currentChecker);
    // final c = positions.removeAt(index);
    // positions.insert(0, c);
    final res = _gameScreenService.getFreeCellsAfterAttack(
        checker: positions[checkerId],
        cells: state.gameField.cells,
        blackPositions: state.gameField.blackPositions,
        whitePositions: state.gameField.whitePositions);
    if (res.isEmpty) {
      for (int i = 0; i < positions.length; i++) {
        final attackPositions = _gameScreenService.getFreeCellsAfterAttack(
            checker: positions[i],
            cells: state.gameField.cells,
            blackPositions: state.gameField.blackPositions,
            whitePositions: state.gameField.whitePositions);
        if (attackPositions.isNotEmpty) {
          if (positions[i] != positions[checkerId]) {
            return i;
          } else {
            return -1;
          }
        }
      }
    }

    return null;
  }

  void selectWhiteChecker(
    int index,
  ) {
    if (state.gameField.currentSide != Colors.white) {
      emit(state.copyWith(
          gameField: state.gameField
              .copyWith(attackLightedPositions: [], lightedPositions: [])));
      return;
    }

    unselectWhiteCheckers();
    unselectBlackCheckers();
    final canOtherAttack = anyHasAttack(index);
    if (canOtherAttack != null && canOtherAttack != -1) {
      selectWhiteChecker(canOtherAttack);
      return;
    }
    final whitePositions = [...gameField.whitePositions];
    whitePositions[index] =
        gameField.whitePositions[index].copyWith(isSelected: true);
    emit(state.copyWith(
        gameField: state.gameField.copyWith(
            whitePositions: whitePositions,
            lightedPositions: [],
            attackLightedPositions: _gameScreenService.getFreeCellsAfterAttack(
                checker: gameField.whitePositions[index],
                cells: state.gameField.cells,
                blackPositions: state.gameField.blackPositions,
                whitePositions: state.gameField.whitePositions))));
    if (state.gameField.attackLightedPositions.isEmpty) {
      emit(state.copyWith(
          gameField: gameField.copyWith(
              lightedPositions: _gameScreenService.getFreeCells(
                  cells: gameField.cells,
                  blackPositions: gameField.blackPositions,
                  whitePositions: gameField.whitePositions,
                  checker: state.gameField.whitePositions[index]))));
    }
    print(
        "_gameField!.attackLightedPositions ${state.gameField!.attackLightedPositions}");
    // print("${_gameField!.lightedPositions } ${_gameField!.attackLightedPositions}");
  }

  void unselectBlackCheckers() {
    final blackPositions = [...state.gameField.blackPositions];
    for (int i = 0; i < blackPositions.length; i++) {
      blackPositions[i] = blackPositions[i].copyWith(isSelected: false);
    }
    emit(state.copyWith(
        gameField: state.gameField.copyWith(blackPositions: blackPositions)));
  }

  void unselectWhiteCheckers() {
    final whitePositions = [...state.gameField.whitePositions];
    for (int i = 0; i < whitePositions.length; i++) {
      whitePositions[i] = whitePositions[i].copyWith(isSelected: false);
    }
    emit(state.copyWith(
        gameField: state.gameField.copyWith(whitePositions: whitePositions)));
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
            isQueen: false,
            color: color,
            position:
                GameCell(row: row1, column: 2, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row1, column: 4, cellColor: CellColor.black)),
        Checker(
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
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 2, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 4, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 6, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 8, cellColor: CellColor.black))
      ]);
    } else {
      int row1 = 1;
      int row2 = 2;
      int row3 = 3;
      cells.addAll([
        Checker(
            color: color,
            position: GameCell(
              row: row1,
              column: 1,
              cellColor: CellColor.black,
            )),
        Checker(
            color: color,
            position:
                GameCell(row: row1, column: 3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row1, column: 5, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row1, column: 7, cellColor: CellColor.black))
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
            isQueen: false,
            color: color,
            position:
                GameCell(row: row3, column: 1, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 3, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 5, cellColor: CellColor.black)),
        Checker(
            color: color,
            position:
                GameCell(row: row3, column: 7, cellColor: CellColor.black))
      ]);
    }

    return cells;
  }

  bool isLightedCell(GameCell cell) {
    return state.gameField.lightedPositions.contains(cell);
  }

  bool isAttackLightedCell(GameCell cell) {
    return state.gameField.attackLightedPositions.contains(cell);
  }

  GameCell? findTwiceEnemyDiagCells(List<GameCell> positions) {
    return _gameScreenService.findTwiceEnemyDiagCells(positions);
  }
}
