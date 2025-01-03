import 'package:checker/feature/game_screen/data/api/game_screen_api.dart';
import 'package:checker/feature/game_screen/data/dto/emoji_dto.dart';
import 'package:checker/feature/game_screen/data/repository/ionline_game_repository.dart';
import 'package:checker/feature/game_screen/domain/models/emoji_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IOnlineGameRepository)
class OnlineGameRepository implements IOnlineGameRepository{
  final GameScreenApi _gameScreenApi;

  OnlineGameRepository({required GameScreenApi gameScreenApi}) : _gameScreenApi = gameScreenApi;
  @override
  Future<void> sendEmoji(EmojiModel emojiModel) {
    return _gameScreenApi.sendEmoji(EmojiDto(sessionId: emojiModel.sessionId, emoji: emojiModel.emoji, accessTokenFrom: emojiModel.accessTokenFrom));
  }

  @override
  Future<void> lose(String sessionId, String nickname) {
    return _gameScreenApi.lose(sessionId, nickname);
  }

}