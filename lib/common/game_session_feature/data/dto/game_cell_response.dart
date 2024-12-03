import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_cell_response.g.dart';

@JsonSerializable()
class GameCellResponse {
  final int row;
  final int column;
  @JsonKey(name: "cell_color")
  final String cellColor;
  factory GameCellResponse.fromJson(Map<String, dynamic> json) =>
      _$GameCellResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GameCellResponseToJson(this);

  GameCellResponse({required this.row, required this.column, required this.cellColor});
}