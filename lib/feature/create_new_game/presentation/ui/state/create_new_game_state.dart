import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';



part 'create_new_game_state.freezed.dart';

@freezed
class CreateNewGameState with _$CreateNewGameState {
  const factory CreateNewGameState(
      {@Default(GameSession())GameSession session,@Default(false) bool isPrivate,@Default("") String password}) = _CreateNewGameState;
}
