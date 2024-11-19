import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_field.freezed.dart';

@freezed
class GameField with _$GameField{
  const factory GameField({
    @Default([]) List<GameCell> cells,
    @Default([]) List<Checker> whitePositions,
    @Default([]) List<Checker> blackPositions,
    @Default([]) List<Checker> deadWhitePositions,
    @Default([]) List<Checker> deadBlackPositions,
    @Default([]) List<GameCell> lightedPositions,
    @Default([]) List<GameCell> attackLightedPositions,
    @Default(Colors.white) Color currentSide,


})=_GameField;
}