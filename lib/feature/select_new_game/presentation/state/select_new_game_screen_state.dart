import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_new_game_screen_state.freezed.dart';

@freezed
class SelectNewGameScreenState with _$SelectNewGameScreenState {
  const factory SelectNewGameScreenState({
    @Default(true) final bool enableSound

}) = _SelectNewGameScreenState;
}