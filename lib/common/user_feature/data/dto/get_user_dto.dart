import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_dto.g.dart';

@JsonSerializable()
class GetUserDto{
  @JsonKey(name: "access_token")
  final String accessToken;

  GetUserDto({ required this.accessToken});

  factory GetUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserDtoToJson(this);

}