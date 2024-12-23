import 'package:json_annotation/json_annotation.dart';

part 'emoji_dto.g.dart';

@JsonSerializable()
class EmojiDto{
  @JsonKey(name: 'session_id')
   final String sessionId;
  @JsonKey(name: 'emoji')
       final String emoji;
  @JsonKey(name: 'access_token_from')
       final String accessTokenFrom;
   Map<String, dynamic> toJson() => _$EmojiDtoToJson(this);
   factory EmojiDto.fromJson(Map<String, dynamic> json) =>
       _$EmojiDtoFromJson(json);
  EmojiDto({required this.sessionId, required this.emoji, required this.accessTokenFrom});
}