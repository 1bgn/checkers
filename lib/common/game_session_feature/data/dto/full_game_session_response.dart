import 'package:checker/common/game_session_feature/data/dto/full_game_session_item_response.dart';
import 'package:checker/common/game_session_feature/data/dto/game_field_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_game_session_response.g.dart';

@JsonSerializable()
class FullGameSessionDtoResponse{
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "game_session_item")
  final FullGameSessionItemResponse gameSessionItem;
  @JsonKey(name: "game_field")
  final GameFieldResponse gameField;
  factory FullGameSessionDtoResponse.fromJson(Map<String, dynamic> json) =>
  _$FullGameSessionDtoResponseFromJson(json);

  FullGameSessionDtoResponse({required this.id, required this.gameSessionItem, required this.gameField});


  Map<String, dynamic> toJson() => _$FullGameSessionDtoResponseToJson(this);



}