import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checker.freezed.dart';

@freezed
class Checker with _$Checker{
  const factory Checker({
    @Default(Colors.white) Color color,
    @Default(GameCell())GameCell position,
    @Default(false) bool isSelected,
    @Default(false) bool isQueen
})=_Checker;

  // _CheckerF copy({GameCellF? position, bool? isSelected, bool? isQueen}) {
  //   return _CheckerF(
  //       color: color,
  //       position: position ?? this.position,
  //       isSelected: isSelected ?? this.isSelected,
  //       isQueen: isQueen ?? this.isQueen);
  // }

}