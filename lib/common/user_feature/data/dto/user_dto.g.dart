// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      nickname: json['nickname'] as String,
      accessToken: json['access_token'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'access_token': instance.accessToken,
      'id': instance.id,
    };
