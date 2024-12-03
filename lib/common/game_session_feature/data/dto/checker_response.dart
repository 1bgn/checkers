import 'package:checker/common/game_session_feature/data/dto/game_cell_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checker_response.g.dart';

@JsonSerializable()
class CheckerResponse {
  final String color;
  final GameCellResponse position;
  @JsonKey(name: "is_selected")
  final bool isSelected;
  @JsonKey(name: "is_queen")
  final bool isQueen;
  factory CheckerResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckerResponseToJson(this);
  CheckerResponse({required this.color, required this.position, required this.isSelected, required this.isQueen});
}