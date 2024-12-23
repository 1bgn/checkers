import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_cell.freezed.dart';

@freezed
class GameCell with _$GameCell{
const factory GameCell({
@Default(0)  int row,
  @Default(0) int column,
  @Default(CellColor.white) CellColor cellColor
})=_GameCell;

}
enum CellColor {
  black,white
}