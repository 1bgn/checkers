import 'package:checker/common/game_session_feature/data/dto/game_cell_response.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:injectable/injectable.dart';

@injectable
class GameCellMapper {
  GameCell to(GameCellResponse gameCell) {
    return GameCell(
        row: gameCell.row,
        column: gameCell.column,
        cellColor:
            gameCell.cellColor == "black" ? CellColor.black : CellColor.white);
  }
  GameCellResponse from(GameCell gameCell) {
    return GameCellResponse(

        row: gameCell.row,
        column: gameCell.column,
        cellColor:
        gameCell.cellColor == CellColor.black? "black": "white");
  }
}
