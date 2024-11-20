import 'package:checker/feature/server_list_screeen/data/dto/game_player_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'game_session_dto.g.dart';
@JsonSerializable()

class GameSessionDto{
  @JsonKey(name: 'is_private')
final bool isPrivate;
final int? password;
  @JsonKey(name: 'is_finished')
final bool isFinished;
  @JsonKey(name: 'white_game_player')
final GamePlayerDto whiteGamePlayer;
  @JsonKey(name: 'black_game_player')
final GamePlayerDto blackGamePlayer;
final GamePlayerDto? winner;
factory GameSessionDto.fromJson(Map<String, dynamic> json) =>
    _$GameSessionDtoFromJson(json);
Map<String, dynamic> toJson() => _$GameSessionDtoToJson(this);
  GameSessionDto({required this.isPrivate, required this.password, required this.isFinished, required this.whiteGamePlayer, required this.blackGamePlayer, required this.winner});
}