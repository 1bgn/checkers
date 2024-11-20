import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse{
  final String nickname;
  @JsonKey(name: "access_token")
  final String accessToken;

  UserResponse({required this.nickname, required this.accessToken});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

}