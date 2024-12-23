import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto{
  final String nickname;
  @JsonKey(name: "access_token")
  final String accessToken;
  final String id;




  UserDto({required this.nickname, required this.accessToken, required this.id});

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}