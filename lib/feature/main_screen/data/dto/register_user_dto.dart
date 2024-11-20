import 'package:json_annotation/json_annotation.dart';

part 'register_user_dto.g.dart';

@JsonSerializable()
class RegisterUserDto{
  final String nickname;
  factory RegisterUserDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserDtoFromJson(json);

  RegisterUserDto({required this.nickname});
  Map<String, dynamic> toJson() => _$RegisterUserDtoToJson(this);
}