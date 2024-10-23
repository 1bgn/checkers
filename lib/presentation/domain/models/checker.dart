import 'package:checker/presentation/domain/models/checker_position.dart';
import 'package:checker/presentation/domain/models/game_cell.dart';
import 'package:flutter/material.dart';

class Checker {
  final Color color;
  final GameCell position;
  final bool isSelected;
  final bool isQueen;

  @override
  String toString() {
    return 'Checker{color: $color, position: $position}';
  }

  Checker copy({GameCell? position, bool? isSelected, bool? isQueen}) {
    return Checker(
        color: color,
        position: position ?? this.position,
        isSelected: isSelected ?? this.isSelected,
        isQueen: isQueen ?? this.isQueen);
  }

  // CheckerPosition getCheckerPosition(double cellWidth){
  //   final halfWidth = cellWidth;
  //  switch(position.column){
  //    case 'A':
  //      return CheckerPosition(x: halfWidth*1, y: halfWidth*position.row);
  //    case 'B':
  //      return CheckerPosition(x: halfWidth*2, y: halfWidth*position.row);
  //    case 'C':
  //      return CheckerPosition(x: halfWidth*3, y: halfWidth*position.row);
  //    case 'D':
  //      return CheckerPosition(x: halfWidth*4, y: halfWidth*position.row);
  //    case 'E':
  //      return CheckerPosition(x: halfWidth*5, y: halfWidth*position.row);
  //    case 'F':
  //      return CheckerPosition(x: halfWidth*6, y: halfWidth*position.row);
  //    case 'G':
  //      return CheckerPosition(x: halfWidth*7, y: halfWidth*position.row);
  //    case 'H':
  //      return CheckerPosition(x: halfWidth*8, y: halfWidth*position.row);
  //    default:
  //      throw Exception("Не корректный столбец");
  //  }
  // }

  Checker(
      {required this.color,
      required this.position,
      this.isSelected = false,
      this.isQueen = false});
}
