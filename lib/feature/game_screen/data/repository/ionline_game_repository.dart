import '../../domain/models/emoji_model.dart';

abstract class IOnlineGameRepository{
  Future<void> sendEmoji(EmojiModel emojiModel);
  Future<void> lose(String sessionId,String nickname);

}