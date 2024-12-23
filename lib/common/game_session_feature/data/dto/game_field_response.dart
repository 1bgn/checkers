import 'package:checker/common/game_session_feature/data/dto/checker_response.dart';
import 'package:checker/common/game_session_feature/data/dto/game_cell_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_field_response.g.dart';

@JsonSerializable()
class GameFieldResponse{
  factory GameFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$GameFieldResponseFromJson(json);
  // final List<GameCellResponse> cells;
  @JsonKey(name: "white_positions")
  final List<CheckerResponse> whitePositions;
  @JsonKey(name: "current_side")
  final String currentSide;
  @JsonKey(name: "black_positions")
  final List<CheckerResponse> blackPositions;
  @JsonKey(name: "dead_black_positions")
  final List<CheckerResponse> deadBlackPositions;
  @JsonKey(name: "dead_white_positions")
  final List<CheckerResponse> deadWhitePositions;
  @JsonKey(name: "lighted_positions")
  final List<GameCellResponse> lightedPositions;
  @JsonKey(name: "attack_lighted_positions")
  final List<GameCellResponse> attackLightedPositions;

  GameFieldResponse({required this.whitePositions, required this.currentSide, required this.blackPositions, required this.deadBlackPositions, required this.deadWhitePositions, required this.lightedPositions, required this.attackLightedPositions});

  Map<String, dynamic> toJson() => _$GameFieldResponseToJson(this);



}