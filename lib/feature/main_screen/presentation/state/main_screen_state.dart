import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/user_feature/domain/model/user.dart';


part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState(
      {@Default(0) int pageIndex,
      @Default(User()) User currentUser}) = _MainScreenState;
}
