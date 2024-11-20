import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_user.freezed.dart';

@freezed
class MainUser with _$MainUser{
  const factory MainUser({
    @Default(0) int id,
    @Default("") String nickname,
    @Default("") String accessToken,

  })=_MainUser;
}