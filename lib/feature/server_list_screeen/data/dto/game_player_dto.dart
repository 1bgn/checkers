
import 'package:json_annotation/json_annotation.dart';

part 'game_player_dto.g.dart';

@JsonSerializable()
class GamePlayerDto {
  final int id;
  final String nickname;
  final String token;
  factory GamePlayerDto.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GamePlayerDtoToJson(this);
  GamePlayerDto({required this.id, required this.nickname, required this.token});
}