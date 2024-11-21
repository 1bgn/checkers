import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto{
  final String nickname;
  @JsonKey(name: "access_token")
  final String accessToken;

  UserDto({required this.nickname, required this.accessToken});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
  _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

}