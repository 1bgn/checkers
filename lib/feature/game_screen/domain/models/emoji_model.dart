import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji_model.freezed.dart';



@freezed
class EmojiModel with _$EmojiModel{
  const factory EmojiModel({
    required final String sessionId,
    required final String emoji,
    required final String accessTokenFrom,

}) = _EmojiModel;

}