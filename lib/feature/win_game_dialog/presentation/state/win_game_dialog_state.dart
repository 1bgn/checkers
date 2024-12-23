import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'win_game_dialog_state.freezed.dart';

@freezed
class WinGameDialogState with _$WinGameDialogState {
  const factory WinGameDialogState(
      {@Default(GameSession())GameSession gameSession,

      }) = _WinGameDialogState;
}
