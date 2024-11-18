import 'checker_position.dart';

class GameCell implements Comparable<GameCell>{
  final int row;
  final int column;
  final CellColor cellColor;

  GameCell({required this.row, required this.column, required this.cellColor});
  CheckerPosition getPosition(double cellWidth){
    final halfWidth = cellWidth;
    if (column >=1 && column<=8){
      return CheckerPosition(x: halfWidth*column, y: halfWidth*row);

    }else{
      throw Exception("Не корректный столбец");

    }
    // switch(column){
    //   case 'A':
    //     return CheckerPosition(x: halfWidth*1, y: halfWidth*row);
    //   case 'B':
    //     return CheckerPosition(x: halfWidth*2, y: halfWidth*row);
    //   case 'C':
    //     return CheckerPosition(x: halfWidth*3, y: halfWidth*row);
    //   case 'D':
    //     return CheckerPosition(x: halfWidth*4, y: halfWidth*row);
    //   case 'E':
    //     return CheckerPosition(x: halfWidth*5, y: halfWidth*row);
    //   case 'F':
    //     return CheckerPosition(x: halfWidth*6, y: halfWidth*row);
    //   case 'G':
    //     return CheckerPosition(x: halfWidth*7, y: halfWidth*row);
    //   case 'H':
    //     return CheckerPosition(x: halfWidth*8, y: halfWidth*row);
    //   default:
    //     throw Exception("Не корректный столбец");
    // }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCell &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          column == other.column &&
          cellColor == other.cellColor;

  @override
  int get hashCode => row.hashCode ^ column.hashCode ^ cellColor.hashCode;



  @override
  String toString() {
    return 'GameCell{row: $row, column: $column, cellColor: $cellColor}';
  }

  @override
  int compareTo(GameCell other) {
    if(column == other.column && row == other.row){
      return 0;
    }else if(column>other.column && row >other.column){
      return 1;
    }
    return -1;
  }
}
enum CellColor {
  black,white
}