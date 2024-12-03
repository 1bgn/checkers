import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_game_session.freezed.dart';

@freezed
class CreateGameSession with _$CreateGameSession{
const factory CreateGameSession({
  @Default("") String password,
  @Default(false) bool isPrivate,
  @Default("") String createNickName
})=_CreateGameSession;
}