import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(fromJson: true)
sealed class User with _$User{
  const factory User({
    @Default("") String id,
    @Default("") String nickname,
    @Default("") String accessToken,

  })=_User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}