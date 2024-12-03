import 'package:checker/common/game_session_feature/data/dto/checker_response.dart';
import 'package:checker/common/game_session_feature/mapper/game_cell_mapper.dart';
import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/di_container.dart';
@injectable
class GameCheckerMapper {
  Checker to(CheckerResponse r){
    final GameCellMapper cellMapper = getIt();
    return Checker(
        color: r.color == "black" ? Colors.black : Colors.white,
        isQueen: r.isQueen,
        isSelected: r.isSelected,
        position: cellMapper.to(r.position));
  }
  CheckerResponse from(Checker r){
    final GameCellMapper cellMapper = getIt();
    return CheckerResponse(
        color: r.color == Colors.black ? "black" : "white",
        isQueen: r.isQueen,
        isSelected: r.isSelected,
        position: cellMapper.from(r.position));
  }
}