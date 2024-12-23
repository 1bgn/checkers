import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_sessions_state.freezed.dart';

@freezed
class GameSessionsState with _$GameSessionsState {
  const factory GameSessionsState(
      {@Default([])List<GameSessionItem> sessions,}) = _GameSessionsState;
}
