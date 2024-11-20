import 'package:checker/feature/main_screen/domain/model/main_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState(
      {@Default(0) int pageIndex,
      @Default(MainUser()) MainUser currentUser}) = _MainScreenState;
}
