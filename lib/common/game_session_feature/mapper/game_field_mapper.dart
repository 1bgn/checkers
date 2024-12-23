import 'package:checker/common/game_session_feature/data/dto/game_field_response.dart';
import 'package:checker/common/game_session_feature/mapper/game_cell_mapper.dart';
import 'package:checker/common/game_session_feature/mapper/game_checker_mapper.dart';
import 'package:checker/core/di/di_container.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../feature/game_screen/domain/models/game_field.dart';
@injectable
class GameFieldMapper {
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
  GameField to(GameFieldResponse gameFieldResponse) {
    final gameCellMapper = getIt<GameCellMapper>();
    final checkerMapper = getIt<GameCheckerMapper>();
    // final cells =
    //     gameFieldResponse.cells.map((e) => gameCellMapper.to(e)).toList();
    final whitePositions = gameFieldResponse.whitePositions
        .map((e) => checkerMapper.to(e))
        .toList();
    final blackPositions = gameFieldResponse.blackPositions
        .map((e) => checkerMapper.to(e))
        .toList();
    final deadBlackPositions = gameFieldResponse.deadBlackPositions
        .map((e) => checkerMapper.to(e))
        .toList();
    final deadWhitePositions = gameFieldResponse.deadWhitePositions
        .map((e) => checkerMapper.to(e))
        .toList();
    final lightedPositions = gameFieldResponse.lightedPositions.map((e)=>gameCellMapper.to(e)).toList();
    final attackLightedPositions = gameFieldResponse.attackLightedPositions.map((e)=>gameCellMapper.to(e)).toList();
    return GameField(
      currentSide: gameFieldResponse.currentSide=="white"?Colors.white:Colors.black,
        cells: initCells(),
        lightedPositions: lightedPositions,
        attackLightedPositions: attackLightedPositions,
        blackPositions: blackPositions,
        whitePositions: whitePositions,
        deadBlackPositions: deadBlackPositions,
        deadWhitePositions: deadWhitePositions);
  }
  GameFieldResponse from(GameField gameFieldResponse) {
    final gameCellMapper = getIt<GameCellMapper>();
    final checkerMapper = getIt<GameCheckerMapper>();
    // final cells =
    // gameFieldResponse.cells.map((e) => gameCellMapper.from(e)).toList();
    final whitePositions = gameFieldResponse.whitePositions
        .map((e) => checkerMapper.from(e))
        .toList();
    final blackPositions = gameFieldResponse.blackPositions
        .map((e) => checkerMapper.from(e))
        .toList();
    final deadBlackPositions = gameFieldResponse.deadBlackPositions
        .map((e) => checkerMapper.from(e))
        .toList();
    final deadWhitePositions = gameFieldResponse.deadWhitePositions
        .map((e) => checkerMapper.from(e))
        .toList();
    final lightedPositions = gameFieldResponse.lightedPositions.map((e)=>gameCellMapper.from(e)).toList();
    final attackLightedPositions = gameFieldResponse.attackLightedPositions.map((e)=>gameCellMapper.from(e)).toList();
    return GameFieldResponse(
        // cells: cells,
        currentSide: gameFieldResponse.currentSide==Colors.white?"white":"black",
        lightedPositions: lightedPositions,
        attackLightedPositions: attackLightedPositions,
        blackPositions: blackPositions,
        whitePositions: whitePositions,
        deadBlackPositions: deadBlackPositions,
        deadWhitePositions: deadWhitePositions);
  }
}
