import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_to_game.freezed.dart';

@freezed
class ConnectToGame with _$ConnectToGame{
  const factory ConnectToGame({
    @Default("") String nickname,
    @Default("") String sessionId,

  })=_ConnectToGame;
}