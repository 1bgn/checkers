import 'package:checker/common/game_session_feature/data/dto/game_field_response.dart';
import 'package:checker/common/user_feature/data/dto/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_game_session_item_response.g.dart';

@JsonSerializable()
class FullGameSessionItemResponse{
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "is_private")
  final bool isPrivate;
  @JsonKey(name: "is_finished")
  final bool isFinished;
  final String? password;
  @JsonKey(name: "white_gamer",)
  final UserDto? whiteGamer;
  @JsonKey(name: "black_gamer")
  final UserDto? blackGamer;
  @JsonKey(name: "creator")
  final UserDto creator;
  @JsonKey(name: "session_id")
  final String sessionId;
  factory FullGameSessionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$FullGameSessionItemResponseFromJson(json);

  FullGameSessionItemResponse({required this.id, required this.isPrivate, required this.isFinished, required this.password, required this.whiteGamer, required this.blackGamer, required this.creator, required this.sessionId});



  Map<String, dynamic> toJson() => _$FullGameSessionItemResponseToJson(this);



}