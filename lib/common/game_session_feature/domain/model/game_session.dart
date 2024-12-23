import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';

@freezed
class GameSession with _$GameSession{
  const factory GameSession({
    @Default("") String id,
    @Default(GameField()) GameField gameField,
    @Default(GameSessionItem()) GameSessionItem gameSessionItem
})=_GameSession;
}